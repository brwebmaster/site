class ChangeTypeSuidAndName < ActiveRecord::Migration
  def change
  	change_column :users, :stanfordid, :string
  	rename_column :users, :undergrad, :is_undergrad
  end
end
