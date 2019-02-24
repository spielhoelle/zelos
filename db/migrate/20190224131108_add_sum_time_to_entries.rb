class AddSumTimeToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :sum_time, :boolean, default: false
  end
end
