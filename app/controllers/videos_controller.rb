class VideosController < ApplicationController
  def index
    @videos = ChannelVideo.order(:created_at).last(12)
    thumbnail_urls = @videos.map(&:thumbnail_url)

    if stale?(etag: thumbnail_urls)
      respond_to do |format|
        format.json { render json: @videos }
      end
    end
  end
end
