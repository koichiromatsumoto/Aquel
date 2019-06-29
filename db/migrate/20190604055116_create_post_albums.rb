class CreatePostAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :post_albums do |t|
      t.references :post, foreign_key: true
      t.references :album, foreign_key: true

      t.timestamps
    end
  end
end
