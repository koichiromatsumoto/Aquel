class RemoveColumnFromRelationships < ActiveRecord::Migration[5.2]
  def change
  	remove_column :relationships, :follow_id
  	remove_column :relationships, :user_id
  end
end
