class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  belongs_to :user

  PHOTO_ID = 'photo_id'
  AVATAR = 'avatar'

  validates :file,
    presence: true,
    file_size: { less_than_or_equal_to: 1.megabytes },
    file_content_type: { allow: /^image\/.*/ }

  scope :avatar, -> {
    where('tag = ?', AVATAR).order(updated_at: :DESC).limit(1)
  }

  scope :photo_id, -> {
    where('tag = ?', PHOTO_ID).order(updated_at: :DESC).limit(1)
  }

end
