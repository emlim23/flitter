class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => :edit #, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @title = "Flitter Users"
    @users = User.paginate(:page => params[:page], :per_page => 20)
  end

  def new
  	@user = User.new
  	@title = "Sign Up!"
  end

  def show
  	param_val = params[:id]
    if params[:id].nil? # because of the custom routing, we have to check if the routes passed the username as ID or as the actual username param
      param_val = params[:username]
    end

    @user = User.find_by_username(param_val) 
    @micropost = Micropost.new if signed_in?
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 10)

    if @user.nil?
  	  @title = ""
    else
      @title =  @user.fullname
    end
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      # sign in the newly create user
      sign_in @user
      flash[:success] = "Welcome to Flitter!" # To show a one time message after the account has been created
  		redirect_to :action => "show", :id => @user.username #show the profile page of the newly created user      
  	else
	  	@title = "Sign Up!"
	  	render 'new'
	  end
  end

  def edit
    @user = current_user
    @title = "Edit User Profile"
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated!"
      redirect_to :action => "show", :id => @user.username  
    else
      @title = "Edit User Profile"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  private
    def correct_user
      user = User.find_by_username(params[:username]) 

      redirect_to(root_path) unless current_user?(user)
    end

    def admin_user
      user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(user)
    end
end
