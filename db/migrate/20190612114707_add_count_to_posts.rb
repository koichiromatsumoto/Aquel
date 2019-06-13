class AddCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :count, :integer, null: false, default: 0
  end
end
