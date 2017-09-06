class AddInvoiceDiscount < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :discount, :integer, default: 0, null: false
  end
end
