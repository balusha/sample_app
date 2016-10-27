module SessionsHelper
	def sign_in(user, options = {})
		token = User.new_remember_token
		cookies.permanent[:remember_token] = token
		user.update_attribute(:remember_token, User.encrypt(token))
		self.current_user = user
	end

	def current_user= (user)
		@current_user = user
	end

	def current_user
		if !cookies[:remember_token].nil?
		token = User.encrypt cookies[:remember_token]
		@current_user ||= User.find_by(remember_token: token)
		else
			nil
		end

	end

	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

	def redirect_back_or(default = root_url)
		redirect_to session[:return_to] || default
		session.delete(:return_to)
	end

	private

		def signed_in_user
		 unless signed_in?
		    store_location
		    redirect_to signin_url, notice: 'Please sign in'
		 end
		end

		def unsigned_in_user
		  if signed_in?
	  	    redirect_to current_user, notice: 'You are already have an account'
		  end
		end

end
