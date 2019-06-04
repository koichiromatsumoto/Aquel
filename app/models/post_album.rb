class PostAlbum < ApplicationRecord
  belongs_to :post
  belongs_to :album
end
