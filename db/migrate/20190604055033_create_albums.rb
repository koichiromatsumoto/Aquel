class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :user, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
