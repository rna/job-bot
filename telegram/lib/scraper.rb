# frozen_string_literal: true

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
    extracted_data = @data.map { |link| {}.merge(
      'title' => (link['title']).to_s,
      'source_id' => link['href'].match(/\d+/),
      'technology' => @tech,
      'source' => 'StackOverFlow',
      'link' => "https://stackoverflow.com#{link['href']}") }

    JSON.pretty_generate(extracted_data)

    # @data.map { |link| "https://stackoverflow.com#{link['href']}" }
  end

  # def json_file
  #   json = JSON.pretty_generate(convert_data)
  #   File.open("doc/#{@tech}-remote.json", 'w').write(json)
  # end
end

jobs = Scraper.new("rails")
puts jobs.extract_data
