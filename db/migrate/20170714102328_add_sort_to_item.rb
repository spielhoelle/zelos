class AddSortToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :sort, :integer
  end
end
