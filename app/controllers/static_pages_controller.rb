class StaticPagesController < ApplicationController
  def home
  end

  def history
  end

  def sponsorship
  end

  def login
  	if params[:user]
  		session[:username] = params[:user]
  		session[:name] = params[:name]
  		session[:test] = {:a => 5, :b => 7}
  		redirect_to :controller => :users and return
  	end
  	return_url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  	redirect_to "http://www.stanford.edu/~rkpandey/cgi-bin/brprotected/webauth?u=" + URI.encode(return_url)
  end

  def logout
  	session[:username] = nil
  	redirect_to :controller => :static_pages, :action => :home
  end
end
