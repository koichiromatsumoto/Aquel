class Album < ApplicationRecord
  belongs_to :user

  has_many :post_albums
  has_many :posts, through: :post_albums
end
