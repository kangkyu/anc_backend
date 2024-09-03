require "open-uri"

class ApplicationController < ActionController::Base
  include Secured

  private

  def get_body(uri)
    data = URI.parse(uri).read
    data.html_safe
  rescue => e
    puts e
  end

  def escaped(url)
    URI::Parser.new.escape(url)
  end
end
