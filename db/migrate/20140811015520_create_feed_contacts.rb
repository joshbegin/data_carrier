class CreateFeedContacts < ActiveRecord::Migration
  def change
    create_table :feed_contacts do |t|
      t.integer :feed_id
      t.integer :contact_id
      t.integer :contact_type_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
