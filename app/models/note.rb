class Note < ApplicationRecord
  before_create :set_slug

  def set_slug
    return slug if slug.present?

    5.times do
      new_slug = SecureRandom.hex
      self.slug = new_slug and return if Note.find_by(slug: new_slug).nil?
    end
  end
end
