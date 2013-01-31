class Relationship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id

  belongs_to :friendly, :foreign_key => "user_id", :class_name => "User" 
  belongs_to :friends, :foreign_key => "friend_id", :class_name => "User" 

  validates :user_id,	:presence => true
  validates :friend_id, :presence => true
end
