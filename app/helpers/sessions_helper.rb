module SessionsHelper
	def sign_in(user)
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

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		cu = current_user
		cookies.delete(:remember_token)
		token = User.new_remember_token
		cu.update_attribute(:remember_token, User.encrypt(token))
	end

end
