class AddCustomerIdToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :customer_id, :integer
  end
end
