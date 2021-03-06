module ApplicationHelper
	def is_logged_in my_session
		# To fake login
		# my_session[:user_hash] = {}
		# my_session[:user_hash]["username"] = "user3"
		# my_session[:user_hash]["display_name"] = "User Three"
		# return true
		my_session[:user_hash] and my_session[:user_hash]["username"]
	end

	def sortable(column, title = nil)
		title ||= column.titlecase
		css_class = (column == sort_column) ? "current #{sort_direction}" : nil
		direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
		link_to title, {:sort => column, :direction => direction}, {:class => css_class}
	end
end
