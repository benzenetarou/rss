class FeedsController < ApplicationController

  def index
    parse_rss
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
end
