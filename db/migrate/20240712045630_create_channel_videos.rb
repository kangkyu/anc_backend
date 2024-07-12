class CreateChannelVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :channel_videos do |t|
      t.string :youtube_id, null: false
      t.string :title, null: false
      t.string :thumbnail_url, null: false
      t.text :description

      t.timestamps
    end
  end
end
