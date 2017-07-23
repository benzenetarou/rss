class Feed < ApplicationRecord
  has_many :entry
  has_many :users, through: :user_feeds
  has_many :user_feeds
end
