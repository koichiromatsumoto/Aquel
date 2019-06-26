class RemoveTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :hashtags
  	drop_table :post_hashtags
  end
end
