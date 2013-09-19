class CreateVideoComments < ActiveRecord::Migration
  def change
    create_table :video_comments do |t|
      t.text :comment
      t.string :author
      t.belongs_to :video
      
      t.timestamps
    end
  end
end
