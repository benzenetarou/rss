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
      @feed = Feedjira::Feed.fetch_and_parse("http://toyokeizai.net/list/feed/rss")
    end
end
