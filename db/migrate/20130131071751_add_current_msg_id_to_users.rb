class AddCurrentMsgIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :current_msg_id, :integer, :default => 0
  end
end
