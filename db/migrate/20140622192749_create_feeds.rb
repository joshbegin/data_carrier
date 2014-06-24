class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.text :notes
      t.string :stage_feed_url
      t.string :production_feed_url
      t.datetime :production_start_date
      t.datetime :production_end_date
      t.integer :company_id, index: true
      t.integer :feed_status_id, index: true
      t.integer :feed_frequency_id, index: true
      t.integer :feed_type_id, index: true

      t.timestamps
    end
  end
end
