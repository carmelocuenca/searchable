class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :street_address
      t.string :zip_code
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
