class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.integer :feed_id
      t.string :title
      t.datetime :published
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
