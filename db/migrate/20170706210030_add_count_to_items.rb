class AddCountToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :count, :integer, default: 1
  end
end
