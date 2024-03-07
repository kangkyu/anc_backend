class VideosController < ApplicationController
  def index
    render json: videos.to_json
  end

  private

  def videos
    return [] if list_body.blank?
    if list_body['error'].present?
      puts list_body['error']
      return []
    end
    JSON(list_body)['items'].map do |item|
      {
        id: item['id']['videoId'],
        title: item['snippet']['title'],
        thumbnail_url: item['snippet']['thumbnails']['high']['url']
      }
    end
  end

  def list_body
    @list_body ||= begin
      channel_id = "UCIsWNZwrpO_CnlaXO5Oc6bQ"
      # anconnuri = "https://www.youtube.com/channel/UCIsWNZwrpO_CnlaXO5Oc6bQ"
      # passionworship = "https://www.youtube.com/channel/UCBTZoebaG4rvChzKQ2D80-w"
      my_api_key = ENV["YOUR_YOUTUBE_API_KEY"]
      url = escaped("https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=#{channel_id}&maxResults=10&order=date&type=video&key=#{my_api_key}")
      get_body(url)
    end
  end
end
