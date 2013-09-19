class VideoComment < ActiveRecord::Base
	belongs_to :video

  attr_accessible :author, :comment, :video_id
end
