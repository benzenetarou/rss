class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :feeds, through: :user_feeds
  has_many :user_feeds, class_name: "UserFeed", foreign_key: "user_id"
end
