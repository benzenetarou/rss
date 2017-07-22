class FeedsController < ApplicationController

  def index
    update_database
    @entries = Entry.all.order("published DESC")
  end

  def new
  end

  def show
  end

  private
    def parse_rss
      make_array
      @feed = []
      @feed_list.each do |url|
        @feed.push(Feedjira::Feed.fetch_and_parse(url))
      end
    end

    def make_array
      @feed_list = [
        "http://rssblog.ameba.jp/matsui-kazuyo/rss20.xml",
        "http://jp.techcrunch.com/feed/",
        "http://toyokeizai.net/list/feed/rss"
      ]
    end

    def update_database
        parse_rss
        @new_feed = Feed.new(title: "test", url:"http://jp.techcrunch.com/feed/")
        @feed.each do |website|

          website.entries.each do |entry|
            @new_entry = Entry.new()
            if Entry.find_by(url: entry.url).nil?
            @new_entry.update_attributes(feed_id: 2, title: entry.title, url: entry.url, published: entry.published)
            end
          end
        end
    end
end
