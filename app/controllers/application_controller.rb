class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_user
  include ApplicationHelper

  def get_current_user
  	# @current_user = User.find(10)
  end

  def require_login
		if not is_logged_in session
			flash[:error] = "You must be logged in to do that."
			redirect_to :controller => :static_pages, :action => :home
		end
	end

	def not_found
	  raise ActionController::RoutingError.new('Not Found')
	end

	def server_error
	  raise Exception
	end

	def create
		@email = InterestEmail.new(params[:interest_email])
    	if @email.valid?
      		@email.save
      		flash[:notice] = "Thanks! We'll be in touch soon."
      		redirect_to :controller => :static_pages, :action => :home
    	else
      		flash[:alert] = "Sorry! Something went wrong. Please enter your email again."
      		render :controller => :static_pages, :action => :home
    	end

	end
end
