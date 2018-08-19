class AddExpenseToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :expense, :boolean, default: false
  end
end
