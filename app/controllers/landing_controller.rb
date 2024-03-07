class LandingController < ApplicationController
  def index
    @image_urls = find_image_urls.reject {|a| a.empty? }

    respond_to do |format|
      format.html
      format.json do
        render json: {
          external_url: @image_urls[0],
          image_urls: @image_urls
        }.to_json
      end
    end
  end

  private

  def find_image_urls
    node = Nokogiri::XML::DocumentFragment.parse(this_week_body.to_s)
    node.css(".content-view img").collect { |tag| tag.attributes["data-src"].to_s }
  rescue => e
    puts e
  end

  def find_this_week_url
    node = Nokogiri::XML::DocumentFragment.parse(list_body.to_s)
    node.css(".kboard-list-title a")[1].attributes["href"]
  rescue => e
    puts e
  end

  def this_week_body
    url = "https://anconnuri.com" + find_this_week_url.to_s
    get_body(url)
  end

  def list_body
    url = escaped("https://anconnuri.com/교회소식/?category1=주보&pageid=1")
    get_body(url)
  end
end
