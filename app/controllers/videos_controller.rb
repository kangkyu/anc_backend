class VideosController < ApplicationController
  def index
    @videos = ChannelVideo.order(:created_at).last(12)
    youtube_ids = @videos.map(&:youtube_id)

    if stale?(etag: youtube_ids)
      respond_to do |format|
        format.json { render json: @videos }
      end
    end
  end
end
