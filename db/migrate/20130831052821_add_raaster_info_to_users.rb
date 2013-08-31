class AddRaasterInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :hometown, :string
  	add_column :users, :memory, :string
  	add_column :users, :major, :string
  	add_column :users, :shirt_size, :string
  	add_column :users, :undergrad, :boolean
  	add_column :users, :residence, :string
  	add_column :users, :food, :string
  	add_column :users, :stanfordid, :bigint
  	add_column :users, :birthday, :date
  	add_column :users, :committee, :string
  end
end
