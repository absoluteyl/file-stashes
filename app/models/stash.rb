class Stash < ApplicationRecord
  has_one_attached :attachment

  before_create :generate_uniq_uuid

  def generate_uniq_token
    token = generate_token
    while Stash.find_by_token(token).present?
      token = generate_token
    end
    Kredis.integer("share:#{token}", expires_in: 1.hour).value = self.id
    token
  end

  def self.find_by_token(token)
    find_by(id: Kredis.integer("share:#{token}").value)
  end

  private

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
