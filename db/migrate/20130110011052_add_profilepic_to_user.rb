class AddProfilepicToUser < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string, :default => "no-profile-pic.jpg"
  end
end
