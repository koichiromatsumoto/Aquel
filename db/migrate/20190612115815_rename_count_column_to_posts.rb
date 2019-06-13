class RenameCountColumnToPosts < ActiveRecord::Migration[5.2]
  def change
  	rename_column :posts, :count, :favorites_count
  end
end
