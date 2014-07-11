class AddFieldsToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :transaction_type, :string
    add_column :feeds, :sent_to_data_rail, :boolean
    add_column :feeds, :enhanced_carrier_status, :boolean
    add_column :feeds, :data_rail_api_key, :string
    add_column :feeds, :data_rail_password, :string
    add_column :feeds, :data_rail_queue_priority, :integer
    add_column :feeds, :data_view_username, :string
    add_column :feeds, :data_view_password, :string
    add_column :feeds, :partner, :string
    add_column :feeds, :split_by_data_rail, :boolean
    add_column :feeds, :contact_id, :integer
  end
end
