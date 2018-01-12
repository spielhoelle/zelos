class AddDateToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :item_date, :datetime
  end
end
