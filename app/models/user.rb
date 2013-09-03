class User < ActiveRecord::Base
  include ApplicationHelper
	has_many :photos
  attr_accessible :first_name, :last_name, :year, :bio, :avatar, :sunet, :gender, :is_admin, :is_captain, :is_alumni, :hometown, :memory, :birthday, :major, :undergrad, :shirt_size, :residence, :food, :stanfordid, :committee, :phone, :twitter, :facebook, :quote

  validates :first_name, :last_name, :presence => true

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, 
  default_url: '/assets/StanfordTree.png',
  styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
  }

  # These users can edit/delete any profile
  def self.is_power_user(sunet)
    ["rkpandey", "tdoshi", "namir", "patels"].include? sunet
  end

  def full_name
  	self.first_name + " " + self.last_name
  end

  def get_picture
    if self.avatar.exists?
      ActionController::Base.helpers.image_tag self.avatar.url(:square)
    else
      ActionController::Base.helpers.image_tag "defaultRaas.jpg"
    end
  end

  # This is called in the json response so we have access to the file url (stored in Amazon S3). 
  def avatar_url
    avatar.url
  end
end