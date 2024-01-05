class LandingController < ApplicationController
  def index
    escaper = URI::Parser.new
    @external_url = escaper.escape("https://anconnuri.com/교회소식/?category1=주보&pageid=1")
  end
end
