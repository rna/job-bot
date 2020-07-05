# frozen_string_literal: true

task scrape: :environment do
  puts 'Scraper Started'

  require 'open-uri'
  require 'nokogiri'
  require 'json'
  require 'date'

  # Scraper for StackOverflow
  class Scraper
    def initialize(tech, url)
      @tech = tech
      @doc = Nokogiri::XML(URI.open(url))
      @data = @doc.xpath('//*[contains(concat( " ", @class, " " ),
               concat( " ", "stretched-link", " " ))]')
    end

    def extract_data
      extracted_data = @data.map do |link|
        {}.merge('title' => (link['title']).to_s,
                 'source_id' => link['href'].match(/\d+/),
                 'technology' => @tech, 'source' => 'StackOverFlow',
                 'link' => "https://stackoverflow.com#{link['href']}")
      end
    end

    def upload_to_db
      json_data = JSON.parse(JSON.pretty_generate(self.extract_data))
      json_data.each do |i|
        Job.create(
          title: (i['title']).to_s,
          source_id: (i['source_id']).to_s,
          technology: (i['technology']).to_s,
          source: (i['source']).to_s,
          link: (i['link']).to_s
        )
      end
      puts "Job Data updated #{DateTime.now}"
    end
  end

  tech = 'rails'
  url = "https://stackoverflow.com/jobs?q=#{@tech}&r=true"
  jobs = Scraper.new(tech, url)
  jobs.upload_to_db
end
