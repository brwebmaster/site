class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.string :place
      t.string :event
      t.string :description
      t.timestamp :time

      t.timestamps
    end
  end
end
