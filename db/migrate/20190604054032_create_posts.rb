class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :post_image_id
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
