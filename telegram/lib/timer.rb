loop do
  sleep 120 # 2 min in seconds
  system('ruby telegram/lib/scraper.rb')
end
