class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|

      t.text :name
      t.text :company
      t.string :address
      t.timestamps
    end
  end
end
