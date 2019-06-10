class DefaultStatusToUser < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :users, :status, "true"
  	change_column_default :users, :admin, "false"
  end
end
