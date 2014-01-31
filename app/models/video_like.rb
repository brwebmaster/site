class VideoLike < ActiveRecord::Base
	belongs_to :video

  attr_accessible :liker, :video_id
end
