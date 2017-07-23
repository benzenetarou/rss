class DropUserFeed < ActiveRecord::Migration[5.0]
  def change
    drop_table :user_feeds
  end
end
