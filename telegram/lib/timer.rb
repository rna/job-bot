loop do
  sleep 300 # 5 min in seconds
  system('ruby telegram/lib/scraper.rb')
end
