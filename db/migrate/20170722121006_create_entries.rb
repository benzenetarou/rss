class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.datetime :published
      t.string :url
      t.text :content
      t.references :feed, foreign_key: true

      t.timestamps
    end
  end
end
