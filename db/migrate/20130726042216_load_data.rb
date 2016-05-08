class LoadData < ActiveRecord::Migration
  def up
  	u1 = User.new(:first_name => "Rahul", :last_name => "Pandey", :year => "2013", :bio => "I like to dance and smile and listen!", :is_alumni => true)
  	u1.save(:validate => false)
  	u2 = User.new(:first_name => "Tulsee", :last_name => "Doshi", :year => "2015", :bio =>"Dancing and singing all the way", :is_alumni => false)
  	u2.save(:validate => false)
  end

  def down
  	User.delete_all
  end
end