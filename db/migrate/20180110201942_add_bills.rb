class AddBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.text :title
      t.integer :price
      t.datetime :bill_date
      t.attachment :image
      t.timestamps
    end
  end
end
