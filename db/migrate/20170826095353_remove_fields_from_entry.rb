class RemoveFieldsFromEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :customer_name
    remove_column :entries, :customer_address
  end
end
