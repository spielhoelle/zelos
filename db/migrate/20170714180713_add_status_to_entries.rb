class AddStatusToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :status, :string, default: "open"
  end
end
