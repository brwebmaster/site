class VideosController < ApplicationController
	before_filter :require_login
  include ApplicationHelper
  
  def index
  	@videos = Video.all
    respond_to do |format|
      format.html
      format.json { render json: @videos.to_json(:methods => [:video_id]) }
    end
  end

  def new
  end

  # POST: create a new video
  def create
  	@video = Video.new(params[:video])
    if @video.valid?
      @video.save
      flash[:notice] = "Successfully added new video!"
      redirect_to :action => :index
    else
      flash[:alert] = "There was an error in validating the new video"
      render :action => :new
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
