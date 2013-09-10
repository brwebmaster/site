class VideosController < ApplicationController
	before_filter :require_login
  include ApplicationHelper
  include VideosHelper
  
  def index
    # TODO: implement pagination
  	@videos = Video.limit(5).order("created_at DESC")
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
  	params[:video][:uploader] = session[:user_hash]["username"]
  	@video = Video.new(params[:video])
  	if @video.valid?
  		@video.save
      if (params[:sendEmail])
        VideoMailer.video_email(@video).deliver
      end
  		respond_to do |format|
  			format.html
  			format.json{ render :json => @video}
  		end
  	else
      # error msg should be set in http.post error handler
      render :status => 403, :layout => false
  	end
  end

  def show 
  end

  def edit
  end

  def update
  end

  def destroy
    Video.destroy(params[:id])
    render nothing: true
  end
end
