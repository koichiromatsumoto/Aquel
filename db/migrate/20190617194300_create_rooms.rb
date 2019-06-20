class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
  end

  def change
    add_reference :messages, :room, foreign_key: true
    add_reference :messages, :user, foreign_key: true
  end
end
