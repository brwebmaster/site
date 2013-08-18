class AddGenderAdminToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :string
  	add_column :users, :is_admin, :boolean
  end
end
