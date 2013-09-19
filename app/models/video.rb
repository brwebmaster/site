class Video < ActiveRecord::Base
	has_many :video_comments

  attr_accessible :description, :link, :uploader, :vid

  validates :vid, :presence => {:allow_nil => false}
end
