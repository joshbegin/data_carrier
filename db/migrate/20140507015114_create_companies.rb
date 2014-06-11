class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :parent_company_id
      t.integer :company_type_id
      t.integer :state_id
      t.string :name, index: true
      t.string :additional_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :zip
      t.string :url
      t.string :naic_code, index: true
      t.string :ai_carrier_code, index: true
      t.text :notes

      t.timestamps
    end
  end
end
