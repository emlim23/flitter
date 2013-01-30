module UsersHelper
  def user_resource_name # to make the user model accessible to the signup partial
    :user
  end

  def user_resource
    @resource ||= User.new
  end

  def profile_pic(user)
    if(user.pic?)
    	image_tag(user.pic.url(:medium), :alt => user.fullname)
    else
      image_tag("profile_pics/no-profile-pic.jpg", :alt => user.fullname)
    end
  end

  def profile_pic_small(user)
    if(user.pic?)
  	  image_tag(user.pic.url(:thumb), :alt => user.fullname)
    else
      image_tag("profile_pics/no-profile-pic.jpg", :alt => user.fullname, :width => 40, :height => 40)
    end
  end

  def link_to_user(user)
    link_to user.fullname, "/flitter/user/#{user.username}"
  end

  def link_pic_to_user(user)
    link_to profile_pic_small(user), "/flitter/user/#{user.username}"
  end
end
