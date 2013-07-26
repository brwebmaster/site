class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.integer :user_id
      t.timestamp :date_time

      t.timestamps
    end
  end
end