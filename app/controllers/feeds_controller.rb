class FeedsController < ApplicationController

  def index
    update_database
    @entries = Entry.all.order("published DESC")
    render 'index'
  end

  def new
    @feed = Feed.new
  end

  def confirm
    @url = params[:url]
    @Feed_to_add = Feedjira::Feed.fetch_and_parse(@url)
    @feed = Feed.new
    flash[:success] = "確認します"
    render 'confirm'
  end

  def create
    @feed = Feed.new
    @feed.title = params[:title]
    @feed.url = params[:url]
    @feed.save
    index
  end

  def show
  end

  private
    def parse_rss
      make_array
      @rss = []
      @feed_list.each do |feed|
        @rss.push(Feedjira::Feed.fetch_and_parse(feed.url))
      end
    end

    def make_array
      @feed_list = Feed.all
    end

    def update_database
        parse_rss
        @new_feed = Feed.new(title: "test", url:"http://jp.techcrunch.com/feed/")
        @rss.each do |website|

          website.entries.each do |entry|
            @new_entry = Entry.new()
            if Entry.find_by(url: entry.url).nil?
            @new_entry.update_attributes(feed_id: 2, title: entry.title, url: entry.url, published: entry.published)
            end
          end
        end
    end
end
