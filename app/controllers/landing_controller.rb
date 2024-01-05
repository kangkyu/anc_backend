class LandingController < ApplicationController
  def index
    escaper = URI::Parser.new
    @external_url = escaper.escape("https://anconnuri.com/교회소식/?category1=주보&pageid=1")

    respond_to do |format|
      format.html
      format.json do
        render json: { external_url: @external_url }.to_json
      end
    end
  end
end
