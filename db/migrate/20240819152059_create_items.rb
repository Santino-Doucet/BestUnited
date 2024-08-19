class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :reference
      t.string :brand
      t.string :model
      t.string :color
      t.float :price
      t.float :size
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
