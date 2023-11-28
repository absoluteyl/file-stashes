class Stash < ApplicationRecord
  has_one_attached :attachment

  before_create :generate_uniq_uuid

  private

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
