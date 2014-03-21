class CreateParentCompanies < ActiveRecord::Migration
  def change
    create_table :parent_companies do |t|
      t.string :name
      t.string :additional_name

      t.timestamps
    end
    add_index :parent_companies, :name, unique: true
    add_index :parent_companies, :additional_name, unique: true
  end
end
