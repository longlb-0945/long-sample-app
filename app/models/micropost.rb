class Micropost < ApplicationRecord
  belongs_to :user
  scope :create_at_desc, ->{order created_at: :desc}
  scope :find_user, ->(id){where user_id: id}
  scope :by_user, (lambda do |id|
    where(user_id: Relationship.following_ids(id))
    .or(Micropost.where(user_id: id))
  end)
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_content}
  validate  :picture_size

  private

  def picture_size
    return unless picture.size > Settings.image_size.megabytes
    errors.add :picture, I18n.t("image_valid_size")
  end
end
