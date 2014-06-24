class CreateFeedFrequencies < ActiveRecord::Migration
  def change
    create_table :feed_frequencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
