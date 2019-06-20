class AddFollowToRelatio0nships < ActiveRecord::Migration[5.2]
  def change
  	add_reference :relationships, :follow, foreign_key: { to_table: :users }
  end
end
