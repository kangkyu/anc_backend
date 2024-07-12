namespace :anc do
  desc "Update recent video list"
  task :update_most_recent_videos => :environment do
    videos = list_videos
    if videos.size > 0
      ChannelVideo.delete_all
      videos.each do |video|
        sleep 0.2
        ChannelVideo.create(video)
      end
    end
  end
end

def list_videos
  return [] if list_body.blank?
  if list_body['error'].present?
    puts list_body['error']
    return []
  end
  JSON(list_body)['items'].map do |item|
    {
      youtube_id: item['id']['videoId'],
      title: item['snippet']['title'],
      thumbnail_url: item['snippet']['thumbnails']['high']['url']
    }
  end
end

def list_body
  channel_id = "UCIsWNZwrpO_CnlaXO5Oc6bQ"
  # anconnuri = "https://www.youtube.com/channel/UCIsWNZwrpO_CnlaXO5Oc6bQ"
  # passionworship = "https://www.youtube.com/channel/UCBTZoebaG4rvChzKQ2D80-w"
  my_api_key = ENV["YOUR_YOUTUBE_API_KEY"]
  url = escaped("https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=#{channel_id}&maxResults=12&order=date&type=video&key=#{my_api_key}")
  get_body(url)
end

def get_body(uri)
  data = URI.parse(uri).read
  data.html_safe
rescue => e
  puts e
end

def escaped(url)
  URI::Parser.new.escape(url)
end
