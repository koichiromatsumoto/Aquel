class CreateContactMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_messages do |t|
      t.references :contact, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
