class MicropostsController < ApplicationController
	before_filter :authenticate # authenticate is located at the SessionsHelper
	before_filter :authorized_user, :only => :destroy

	def create
		# Equivalent of Micropost.new. Except this one is automatically tied in with the user
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save 
			flash[:success] = "Micropost created!"
			redirect_to(root_path) # redirect to root path since micropost create don't have a view render
		else
			redirect_to(root_path)
		end
	end

	def destroy
		@micropost.destroy
		redirect_to(root_path) # redirect to root path since micropost destroy don't have a view render
	end

	private

		def authorized_user
			@micropost = Micropost.find(params[:id]) 
			# make sure that the current user is posting to their own
			redirect_to(root_path) unless current_user?(@micropost.user)
		end
end