class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :email
      t.integer :gender_id
      t.string :title
      t.text :notes

      t.timestamps
    end
  end
end
