require File.expand_path('../../config/environment', __dir__)

require 'open-uri'
require 'nokogiri'
require 'json'
class Scraper
  attr_accessor :data

  def initialize(tech)
    @tech = tech
    @doc = Nokogiri::XML(URI.open("https://stackoverflow.com/jobs?q=#{@tech}&r=true"))
    @data = @doc.xpath('//*[contains(concat( " ", @class, " " ),
               concat( " ", "stretched-link", " " ))]')
  end

  def extract_data
    extracted_data = @data.map do |link|
      {}.merge(
        'title' => (link['title']).to_s,
        'source_id' => link['href'].match(/\d+/),
        'technology' => @tech,
        'source' => 'StackOverFlow',
        'link' => "https://stackoverflow.com#{link['href']}"
      )
    end

    json_object = JSON.parse(JSON.pretty_generate(extracted_data))
    
    json_object.each do |i|
      Job.create(
        title: (i['title']).to_s,
        source_id: (i['source_id']).to_s,
        technology: (i['technology']).to_s,
        source: (i['source']).to_s,
        link: (i['link']).to_s
      )
    end
  end
end

jobs = Scraper.new('rails')
jobs.extract_data
