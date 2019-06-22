class AddColumnToContact < ActiveRecord::Migration[5.2]
  def change
  	add_column :contacts, :content, :text
  	add_column :contacts, :reply, :text
  	remove_column :rooms, :owner_id
  end
end
