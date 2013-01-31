# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string(255)
#  fullname            :string(255)
#  email               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  encrypted_password  :string(255)
#  salt                :string(255)
#  admin               :boolean          default(FALSE)
#  picture             :string(255)      default("no-profile-pic.jpg")
#  attach_file_name    :string(255)
#  attach_content_type :string(255)
#  attach_file_size    :integer
#  attach_updated_at   :datetime
#  pic_file_name       :string(255)
#  pic_content_type    :string(255)
#  pic_file_size       :integer
#  pic_updated_at      :datetime
#  current_msg_id      :integer          default(0)
#

class User < ActiveRecord::Base
  attr_accessor		:password
  attr_accessible 	:email, :fullname, :username, :password, :password_confirmation, :pic

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :dependent => :destroy,
                            :foreign_key => "user_id"
  has_many :friendships, :through => :relationships, 
                         :source => :friends

  has_attached_file :pic, :styles => 
           { :medium => "100x100>", :thumb => "40x40>" }

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  username_regex = /^[\S]*$/i

  validates :username, 	:presence 	=> true,
  						:length 	            => { :maximum => 50 }, # set the maximum length of the username 50
  						:uniqueness           => { :case_sensitive => false },
              :format               => { :with => username_regex }
  validates :email, 	:presence 	=> true,
  						:format 	=> { :with => email_regex },
  						:uniqueness => { :case_sensitive => false }
  validates :password,	:presence		=> true,
  						:confirmation 	=> true,
  						:length			=> { :within => 6..40 }

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

  def is_friend?(person)
    relationships.find_by_friend_id(person)
  end

  def befriend!(person)
    person.relationships.create(:friend_id => self.id)
    relationships.create(:friend_id => person.id)
  end

  def unfriend!(friend)
    friend.relationships.find_by_friend_id(self).destroy
    relationships.find_by_friend_id(friend).destroy
  end

  def update_current_msg(msg_id)
    self.update_attribute(:current_msg_id, msg_id)
  end

  def is_viewing_current?(msg_id)
    self.current_msg_id == msg_id
  end

  class << self
    def authenticate(username, submitted_password)
      user = find_by_username(username)
      (user && user.has_password?(submitted_password)) ? user : nil
    end

    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end

  private

    def encrypt_password # method for converting the password to the encrypted one
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password) unless self.password.blank?
    end

    def encrypt(string) 
      # encrypted password format will be:
      # salt + '--' + password
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      # salt format will be:
      # utc time + '--' + password
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string) # method for converting a string to digest
      Digest::SHA2.hexdigest(string)
    end
end
