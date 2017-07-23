class Feed < ApplicationRecord
  has_many :entry
  has_many :users, through: :user_feeds
  has_many :user_feeds, class_name: "UserFeed", foreign_key: "feed_id"
end
