class FeedsController < ApplicationController

  def index
    update_database
    @entries = Entry.all.order("published DESC")
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
    if Feed.find_by(url: params[:url]).nil?
      @feed = Feed.new
      @feed.title = params[:title]
      @feed.url = params[:url]
      @feed.rss_url = params[:rss_url]
      @feed.save
    else
      @feed = Feed.find_by(url: params[:url])
    end
    current_user.register_feed(@feed)
    index
    redirect_to :root
  end

  def show
  end

  def list
    @feeds = Feed.all
  end

  private
    def parse_rss
      make_feed_list
      @rss = []
      @feed_list.each do |feed|
        @rss.push(Feedjira::Feed.fetch_and_parse(feed.rss_url))
      end
    end

    def make_feed_list
      @feed_list = Feed.all
    end

    def update_database
        parse_rss
        @rss.each do |website|
          @feed = Feed.find_by(url: website.url)
          website.entries.each do |article|
            # debugger
            @new_entry = @feed.entry.build(title: article.title, url: article.url, published: article.published)
            if Entry.find_by(url: article.url).nil?
              @new_entry.save
              # @new_entry.update_attributes(title: entry.title, url: entry.url, published: entry.published)
            end
          end
        end
    end
end
