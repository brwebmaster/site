module ApplicationHelper
	def is_logged_in my_session
		not session[:user_hash].nil?
	end
end
