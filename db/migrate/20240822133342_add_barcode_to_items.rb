class AddBarcodeToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :barcode, :string
  end
end
