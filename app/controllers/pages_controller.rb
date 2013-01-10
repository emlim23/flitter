class PagesController < ApplicationController
  def home
  	@title = "Home"

    if(signed_in?) # if user is signed in, change the home to the user's profile page
       redirect_to :controller => "users", :action => "show", :id => current_user.username
    end
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end
end
