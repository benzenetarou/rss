class UserFeedsController < ApplicationController
  def destroy(feed_id)
    current_user.feeds.where(id: feed_id)
    redirect_to feeds_list_path
  end
end
