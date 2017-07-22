class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.integer :feed_id

      t.timestamps
    end
  end
end
