# frozen_string_literal: true

loop do
  sleep 60 # 1 min in seconds
  system('ruby lib/scraper.rb')
end
