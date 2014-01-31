class VideoLikesController < ApplicationController
	before_filter :require_login
	include ApplicationHelper

	def index
		@video = Video.find(params[:video_id])
		@video_likes = @video.video_likes
		respond_to do |format|
			format.json { render json: @video_likes }
		end
	end

	def create
		@video = Video.find(params[:video_id])
		like_params = {}
		like_params[:video_id] = params[:video_id]
		like_params[:liker] = session[:user_hash]["username"]
		@video_like = @video.video_likes.build(like_params)
		if @video_like.valid?
			@video_like.save
			respond_to do |format|
				format.json{ render :json => @video_like }
			end
		else
			puts "could not create new video like"
			render :status => 403, :layout => false
		end
	end

end
