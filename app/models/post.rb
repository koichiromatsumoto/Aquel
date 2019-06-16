class Post < ApplicationRecord

  attachment :post_image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :iine_users, through: :favorites, source: :user
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags
  has_many :post_albums
  has_many :albums, through: :post_albums

  def liked_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
