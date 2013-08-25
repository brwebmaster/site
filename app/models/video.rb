class Video < ActiveRecord::Base
  attr_accessible :description, :link, :uploader

  def video_id
  	#TODO: better error checking here
  	m = self.link.match /watch\?v=(\w+)/
  	m[1]
  end
end
