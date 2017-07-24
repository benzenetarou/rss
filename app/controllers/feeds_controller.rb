class FeedsController < ApplicationController
  before_action :logged_in?, only: [:index, :new, :confirm, :create, :list]
  def index
    update_database
    @entries = Entry.where(feed: current_user.feeds.ids).order("published DESC")
  end

  def new
    @feed = Feed.new
  end

  def confirm
    @url = params[:url]
    begin
      @Feed_to_add = Feedjira::Feed.fetch_and_parse(@url)
    rescue => e
      flash[:danger] = "このURLは対応していません"
      return redirect_to feeds_new_path
    end
    @feed = Feed.new
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

  def destroy
    current_user.user_feeds.where(feed_id: params[:id]).delete_all
    redirect_to feeds_list_path
  end

  def list
    @feeds = current_user.feeds
  end

  private
    def parse_rss
      @feed_list = Feed.all
      @feed_list.map{|feed|
        Feedjira::Feed.fetch_and_parse(feed.rss_url)}
    end

    def update_database
        @rss = parse_rss
        @rss.each do |website|
          @feed = Feed.find_by(url: website.url)
          website.entries.each do |article|
            @new_entry = @feed.entry.build(title: article.title, url: article.url, published: article.published)
            if Entry.find_by(url: article.url).nil?
              @new_entry.save
            end
          end
        end
    end
end
