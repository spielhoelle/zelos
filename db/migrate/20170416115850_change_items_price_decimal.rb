class ChangeItemsPriceDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :price, :decimal, :precision => 10, :scale => 2
  end
end
