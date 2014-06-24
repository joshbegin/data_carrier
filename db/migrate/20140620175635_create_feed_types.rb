class CreateFeedTypes < ActiveRecord::Migration
  def change
    create_table :feed_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
