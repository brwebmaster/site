class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  
  def require_login
		if not is_logged_in session
			flash[:error] = "You must be logged in to do that."
			redirect_to :controller => :static_pages, :action => :home
		end
	end
end
