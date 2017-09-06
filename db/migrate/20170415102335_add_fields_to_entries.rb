class AddFieldsToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :invoice_number, :integer
    add_column :entries, :invoice_date, :datetime
    add_column :entries, :delivery_date, :datetime
  end
end
