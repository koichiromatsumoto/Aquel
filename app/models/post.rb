class Post < ApplicationRecord

  attachment :post_image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :iine_users, through: :favorites, source: :user, dependent: :destroy
  has_many :post_albums, dependent: :destroy
  has_many :albums, through: :post_albums

  validates :user_id, presence: true
  validates :favorites_count, presence: true
  validates :post_image, presence: true
  validates :title, length: { maximum: 16 }
  validates :text, length: { maximum: 1000 }

  def liked_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
