class SessionsController < ApplicationController
  def new
  	@title = "Sign In"
  end

  def create
  	user = User.authenticate(params[:session][:username], params[:session][:password])
  	if user.nil?
  		flash.now[:error] = "Invalid username/password combination."
  		@title = "Sign In"
	  	render 'new'
	else
	  	#handle successful signin
      sign_in user
      if session[:return_to].nil? #show the user feeds page of the signed in user if no return_to redirection
         # redirect_to :controller => :users, :action => 'show', :id => user.username
         redirect_to feeds_path
      else
        redirect_to session[:return_to]
      end

      session[:return_to] = nil # this is to clear the return to so that the user doesn't get stuck to the same page if they logout and login again
	end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end
