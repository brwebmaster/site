class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  
  def require_login
		if is_logged_in
			flash[:error] = "You must be logged in to do that."
			redirect_to :controller => :static, :action => :index
		end
	end
end
