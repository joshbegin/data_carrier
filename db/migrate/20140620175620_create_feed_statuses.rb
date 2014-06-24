class CreateFeedStatuses < ActiveRecord::Migration
  def change
    create_table :feed_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
