class User < ActiveRecord::Base
	has_many :photos
  attr_accessible :first_name, :last_name, :year, :bio

  validates :first_name, :last_name, :year, :presence => true

  def full_name
  	self.first_name + " " + self.last_name
  end
end