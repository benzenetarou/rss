class AddColumnToFeed < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :rss_url, :string
  end
end
