class Post < ApplicationRecord

  attachment :post_image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :iine_users, through: :favorites, source: :user
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags
  has_many :post_albums
  has_many :albums, through: :post_albums


  def like(user)
    favorites.create(user_id: user.id)
  end

  def unlike(user)
    favorites.find_by(user_id: user.id).destroy
  end

  def like?(user)
    iine_users.include?(user)
  end

  def album_in(album)
    post_albums.create(album_id: album.id)
  end

  def album_out(album)
    post_albums.find_by(album_id: album.id).destroy
  end
end
