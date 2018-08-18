class AddCashToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :cash, :boolean, default: false
  end
end
