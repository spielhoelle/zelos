class AddTitleToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :title, :string
  end
end
