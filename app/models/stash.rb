class Stash < ApplicationRecord
  has_one_attached :attachment

  before_create :generate_uniq_uuid

  validates :attachment, presence: true

  def generate_uniq_token
    token = generate_token
    while Stash.find_by_token(token).present?
      token = generate_token
    end
    Kredis.integer(self.class.token_key(token), expires_in: 1.hour).value = self.id
    Kredis.unique_list(stash_key).append(token)
    token
  end

  def tokens
    tokens = Kredis.unique_list(stash_key).elements
    tokens.map do |token|
      if self.class.find_by_token(token).nil?
        Kredis.unique_list(stash_key).remove(token)
        tokens.delete(token)
      end
    end
    tokens
  end

  def filename
    attachment.blob.filename if attachment.attached?
  end

  class << self
    def find_by_token(token)
      find_by(id: Kredis.integer(token_key(token)).value)
    end

    def share_link(token)
      "#{App.scheme}://#{App.host}/t/#{token}"
    end
  end

  private

  def self.token_key(token)
    "token:#{token}"
  end

  def stash_key
    "stash_tokens:#{self.id}"
  end

  def generate_token
    SecureRandom.hex(16)
  end

  def generate_uuid
    SecureRandom.uuid
  end

  def generate_uniq_uuid
    unless self.uuid?
      uuid = generate_uuid
      while Stash.exists?(uuid: uuid)
        uuid = generate_uuid
      end
      self.uuid = uuid
    end
  end
end
