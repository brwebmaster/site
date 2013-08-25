class VideosController < ApplicationController
	before_filter :require_login
  include ApplicationHelper
  include VideosHelper
  
  def index
  	@videos = Video.all
    respond_to do |format|
      format.html
      format.json { render json: @videos }
    end
  end

  def new
  end

  # POST: create a new video
  def create
  	vid = extract_id(params[:video][:link])
  	params[:video][:vid] = vid
  	@video = Video.new(params[:video])
  	if @video.save
  		respond_to do |format|
  			format.html
  			format.json{ render :json => @video}
  		end
  	else
  		flash[:alert] = "There was an error in validating the new video"
      render :action => :index
  	end
  end

  def show 
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
