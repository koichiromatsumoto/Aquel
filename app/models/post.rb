class Post < ApplicationRecord

  attachment :post_image

  belongs_to :user

  has_many :favorites
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags
  has_many :post_albums
  has_many :albums, through: :post_albums
end
