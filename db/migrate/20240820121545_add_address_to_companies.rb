class AddAddressToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :address, :string
    add_column :companies, :latitude, :float
    add_column :companies, :longitude, :float
  end
end
