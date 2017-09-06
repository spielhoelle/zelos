class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :customer_name
      t.text :customer_address
      t.text :notes
      t.timestamps
    end
  end
end
