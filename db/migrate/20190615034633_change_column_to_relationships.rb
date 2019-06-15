class ChangeColumnToRelationships < ActiveRecord::Migration[5.2]
  def change
  	add_foreign_key :relationships, :follow, foreign_key: { to_table: :users }
  end
end
