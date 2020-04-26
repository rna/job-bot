
require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :data

  def initialize
    doc = Nokogiri::XML(URI.open('https://stackoverflow.com/jobs?q=ruby&r=true'))
    @data = doc.xpath('//*[contains(concat( " ", @class, " " ),
               concat( " ", "stretched-link", " " ))]')
  end

  def json_data
    @data.map { |link| {}.merge("title"=>"#{link['title']}", "link" => "https://stackoverflow.com#{link['href']}") }
  end
end

jobs = Scraper.new

puts jobs.json_data
