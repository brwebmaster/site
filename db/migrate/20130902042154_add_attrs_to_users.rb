class AddAttrsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :phone, :string
  	add_column :users, :twitter, :string
  	add_column :users, :facebook, :string
  	add_column :users, :quote, :text

  	change_column :users, :bio, :text
  	change_column :users, :memory, :text
  end
end
