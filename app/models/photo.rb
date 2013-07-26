class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date_time, :filename, :user_id

  validate :profile_pic_unique, :on => :update

  def upload img
		name = img.original_filename
		self.filename = name
		directory = "#{Rails.root.to_s}/app/assets/images/"
	  path = File.join(directory, name)
		File.open(path, "wb") { |f| f.write(img.read) }
	end

	def f_time
		t = self.date_time
		t.getlocal.strftime("%A, %B %d, %Y %I:%M:%S %p") 
	end

	def profile_pic_unique
		self.user.photos.each do |p|
			if p.profile
				errors.add(:profile, "not unique")
				return
			end
		end
	end

end