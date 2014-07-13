class RemoveContactIdFromFeeds < ActiveRecord::Migration
  def change
    remove_column :feeds, :contact_id, :int
  end
end
