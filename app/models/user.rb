class User < ActiveRecord::Base
  include ApplicationHelper
	has_many :photos
  attr_accessible :first_name, :last_name, :year, :bio, :avatar, :sunet, :gender, :is_admin, :is_captain, :is_alumni

  validates :first_name, :last_name, :year, :presence => true

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, 
  default_url: '/assets/defaultRaas.jpg',
  styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
  }

  # These users can edit/delete any prodile
  def power_sunet_users
    Set.new [
      "rkpandey",
      "tdoshi",
      "namir",
      "patels"
    ]
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

  def can_edit(session)
    # if not logged in, no permission
    return false if not is_logged_in(session)
    logged_in_sunet = session[:user_hash]["username"]
    # if looking at own profile, you have permission
    # if you are admin, you have permission
    return true if self.sunet == logged_in_sunet or self.power_sunet_users.member?(logged_in_sunet)
    false
  end
end