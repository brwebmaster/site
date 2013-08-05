class User < ActiveRecord::Base
	has_many :photos
  attr_accessible :first_name, :last_name, :year, :bio, :avatar

  validates :first_name, :last_name, :year, :presence => true

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  def full_name
  	self.first_name + " " + self.last_name
  end
end