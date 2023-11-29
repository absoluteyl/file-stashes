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

  def self.find_by_token(token)
    find_by(id: Kredis.integer(token_key(token)).value)
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
