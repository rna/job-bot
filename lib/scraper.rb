# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'
class Scraper
  attr_accessor :data

  def initialize
    doc = Nokogiri::XML(URI.open('https://stackoverflow.com/jobs?q=ruby&r=true'))
    @data = doc.xpath('//*[contains(concat( " ", @class, " " ),
               concat( " ", "stretched-link", " " ))]')
  end

  def json_data
    json = JSON.pretty_generate(@data.map { |link| {}.merge('title' => (link['title']).to_s, 'link' => "https://stackoverflow.com#{link['href']}") })
    File.open('doc/sample.json', 'w').write(json)
  end
end

jobs = Scraper.new
jobs.json_data
