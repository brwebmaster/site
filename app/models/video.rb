class Video < ActiveRecord::Base
  attr_accessible :description, :link, :uploader, :vid

  validates :vid, :presence => {:allow_nil => false}
end
