class AddIndexToUserFeed < ActiveRecord::Migration[5.0]
  def change
    add_index :user_feeds, :user_id
    add_index :user_feeds, :feed_id
    add_index :user_feeds, [:user_id, :feed_id], unique: true
  end
end
