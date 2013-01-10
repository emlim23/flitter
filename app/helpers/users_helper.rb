module UsersHelper
  def user_resource_name # to make the user model accessible to the signup partial
    :user
  end

  def user_resource
    @resource ||= User.new
  end

  def profile_pic(user)
  	image_tag("profile_pics/#{user.picture}", :alt => user.fullname)
  end

  def profile_pic_small(user)
  	image_tag("profile_pics/#{user.picture}", :alt => user.fullname, :width => 30, :height => 30)
  end

  def link_to_user(user)
    link_to user.fullname, "/flitter/user/#{user.username}"
  end

  def link_pic_to_user(user)
    link_to profile_pic_small(user), "/flitter/user/#{user.username}"
  end
end
