class AddReleaseDateToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :released_on, :date
  end
end
