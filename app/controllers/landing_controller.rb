require "open-uri"

class LandingController < ApplicationController
  def index
    escaper = URI::Parser.new
    list_url = escaper.escape("https://anconnuri.com/교회소식/?category1=주보&pageid=1")
    begin
      body = get_body(list_url)
      this_week_url = "https://anconnuri.com" + find_this_week_url(body.html_safe).to_s
      next_body = get_body(this_week_url)
      @image_url = find_image_url(next_body.html_safe).to_s
    rescue => e
      puts e
    end

    respond_to do |format|
      format.html
      format.json do
        render json: { external_url: @image_url }.to_json
      end
    end
  end

  private

  def get_body(uri)
    data = URI.parse(uri).read
    data
  end

  def find_this_week_url(page)
    node = Nokogiri::XML::DocumentFragment.parse(page.to_s)
    node.css(".kboard-list-title a")[1].attributes["href"]
  rescue => e
    puts e
  end

  def find_image_url(page)
    node = Nokogiri::XML::DocumentFragment.parse(page.to_s)
    node.css(".content-view img")[0].attributes["data-src"]
  rescue => e
    puts e
  end
end
