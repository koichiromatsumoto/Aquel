class Album < ApplicationRecord
  belongs_to :user

  has_many :post_albums, dependent: :destroy
  has_many :posts, through: :post_albums

  def album_in?(post)
    post_albums.where(post_id: post.id).exists?
  end
end
