class AddAddressFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :city, :string
    add_column :contacts, :state_id, :integer
    add_column :contacts, :zip, :string
  end
end
