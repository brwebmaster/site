class VideoComment < ActiveRecord::Base
	belongs_to :video

  attr_accessible :author, :comment
end
