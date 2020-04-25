
require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :data

  def initialize
    doc = Nokogiri::HTML(URI.open('https://stackoverflow.com/jobs?q=ruby&r=true'))
    @data = doc.xpath('//*[contains(concat( " ", @class, " " ),
              concat( " ", "stretched-link", " " ))]')
    # puts @data
  end

  def titles
    @data.map { |link| link['title'] }
  end

  def links
    @data.map { |link| "https://stackoverflow.com#{link['href']}" }
  end
end

jobs = Scraper.new

puts jobs.links
