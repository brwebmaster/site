class AddSunetToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :sunet, :string
  end
end
