class CreatePostAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :post_albums, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :post, foreign_key: true
      t.references :album, foreign_key: true

      t.timestamps
    end
  end
end
