class AddUserToProjx < ActiveRecord::Migration
  def change
    add_column :projxes, :user_id, :integer
  end
end
