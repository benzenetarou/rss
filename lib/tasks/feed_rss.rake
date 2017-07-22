namespace :feed_rss do
  task rss: [:environment] do
    feed = Feedjira::Feed.fetch_and_parse("http://toyokeizai.net/list/feed/rss")

    puts "title         = " + feed.title
    puts "url           = " + feed.url
    puts "last_modified = " + feed.last_modified.to_s

    feed.entries.each do |entry|
      puts "-----"
      puts entry.title
      puts entry.url
    end
  end
end
