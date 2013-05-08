require_relative "crawler"

crawler = Crawler.new("http://xxlgamers.gameme.com/tf")
crawler.go!
puts "ids: #{crawler.steam_ids.count}"
