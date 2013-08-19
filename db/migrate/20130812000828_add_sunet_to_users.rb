class AddSunetToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :sunet, :string
  	add_column :users, :gender, :string, :length => 1
  	add_column :users, :is_admin, :boolean
  end
end
