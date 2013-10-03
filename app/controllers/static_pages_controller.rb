require 'json'

class StaticPagesController < ApplicationController
	include ApplicationHelper
  
  def home
    @images = {"raas1.jpg" => {"caption" => "Stanford Basmati Raas", "active" => false}, 
    "raas2.jpg" => {"caption" => "One of the Nation's Finest Indian Dance Teams", "active" => false},
    "raas3.jpg" => {"caption" => "A Chance to Make Lifelong Friends", "active" => false},
    "raas4.jpg" => {"caption" => "A Chance to Compete Across the Country", "active" => false},
    "raas5.jpg" => {"caption" => "A Chance to Celebrate Indian Culture", "active" => false},
    "raas6.jpg" => {"caption" => "One Team. One Dance.", "active" => true},
    "raas7.jpg" => {"caption" => "Who's Your Boss?", "active" => false}}
  end

  def history
  end

  def sponsorship
  end

  # source for fetching Stanford info
  # https://www.stanford.edu/dept/its/communications/webservices/wiki/index.php/Talk:How_to_fill_out_a_person's_name,_email_address_and_SUNetID_on_a_form_behind_WebAuth_with_PHP
  def login
  	if params[:info]
  		user_hash = JSON.parse URI.unescape(params[:info])
  		# eg. "user_hash"=>{"username"=>"rkpandey", "display_name"=>"Rahul Kumar Pandey", 
  		#"org"=>"Computer Science", "postal_address"=>false, "sn"=>"pandey", "gn"=>"rahul", 
  		#"description"=>false, "phone_number"=>false, "hash"=>"3bae8f0d4c51efd7093a4c18c94f9acb"}}
  		session[:user_hash] = user_hash
  		# TODO: verify hash is correct
  		redirect_to :controller => :users, :action => :login_check and return
  	end
  	return_url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  	redirect_to "http://www.stanford.edu/~tdoshi/cgi-bin/brprotected/webauth?u=" + URI.encode(return_url)
  end

  def logout
  	session[:user_hash] = nil
  	redirect_to :controller => :static_pages, :action => :home, :notice => "Logged out"
  end
end
