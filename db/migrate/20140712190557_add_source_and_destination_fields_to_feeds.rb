class AddSourceAndDestinationFieldsToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :source_system_type_id, :int
    add_column :feeds, :destination_system_type_id, :int
    add_column :feeds, :source_transmission_type_id, :int
    add_column :feeds, :destination_transmission_type_id, :int
    add_column :feeds, :parent_feed_id, :int
  end
end
