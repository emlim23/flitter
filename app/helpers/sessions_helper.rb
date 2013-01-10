module SessionsHelper
	def sign_in(user)
		# create a cookie for the user credentials named remember_token
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		current_user = user
	end

	def current_user=(user) # setter method for current_user
		@current_user = user
	end

	def current_user # getter method for current_user
		# if @current_user is nil then get user from the database
		@current_user ||= user_from_remeber_token 
	end

	def current_user?(user)
		current_user == user
	end

	def signed_in? # property for checking if user is signed in
		!current_user.nil?
	end

	def sign_out # signout action
		# delete the cookies created when the user signed in and set the current user to nil
		cookies.delete(:remember_token)
		current_user = nil
	end

  	def authenticate
      	deny_access unless signed_in?
    end
    
	def deny_access # method for deny access redirection and remembering where the user wants to go before the authentication check
		session[:return_to] = request.fullpath
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end
	
	private

		def user_from_remeber_token # check if the user from the cookie is in the database
			User.authenticate_with_salt(*remember_token) # the * unwraps the remember_token hash so that in can be passed in the the method as two arguments
		end

		def remember_token # remember token helper
			# pull the user credentials from the cookie if it exists, otherwise return nil
			cookies.signed[:remember_token] || [nil, nil]
		end
end
