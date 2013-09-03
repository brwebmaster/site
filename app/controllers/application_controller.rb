class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  
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

	if Rails.env.production?
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionController::UnknownController, with: :render_404
      rescue_from ActionController::UnknownAction, with: :render_404
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
    end
  end

  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
 
  def render_500(exception)
    respond_to do |format|
      format.html { render template: 'errors/internal_server_error', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

end
