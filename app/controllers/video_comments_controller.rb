class VideoCommentsController < ApplicationController
	before_filter :require_login
	include ApplicationHelper

	def index
		@video = Video.find(params[:video_id])
		@video_comments = @video.video_comments.order("created_at ASC")
		respond_to do |format|
			format.json { render json: @video_comments }
		end
	end

	def create
		@video = Video.find(params[:video_id])
		comment_params = {}
		comment_params[:comment] = params[:comment]
		comment_params[:video_id] = params[:video_id]
		comment_params[:author] = session[:user_hash]["username"]
		puts "about to create new video"
		@video_comment = @video.video_comments.build(comment_params)
		if @video_comment.valid?
			@video_comment.save
			respond_to do |format|
				format.json{ render :json => @video_comment }
			end
		else
			puts "could not create new video comment"
			render :status => 403, :layout => false
		end
	end

end
