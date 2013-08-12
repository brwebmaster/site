module ApplicationHelper
	def is_logged_in my_session
		not my_session[:user_hash].nil?
	end
end
