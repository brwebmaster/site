class AddAlumniCaptainToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_alumni, :boolean
  	add_column :users, :is_captain, :boolean
  end
end
