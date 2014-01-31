class AddLikesToVideos < ActiveRecord::Migration
  def change
  	create_table :video_likes do |t|
      t.string :liker
      t.belongs_to :video
      
      t.timestamps
    end
  end
end
