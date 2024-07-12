class VideosController < ApplicationController
  def index
    @videos = ChannelVideo.order(:created_at).last(12)
    render json: @videos
  end
end
