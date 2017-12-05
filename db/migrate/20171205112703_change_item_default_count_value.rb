class ChangeItemDefaultCountValue < ActiveRecord::Migration[5.0]
  def change
    change_column_default :items, :count, 0
  end
end
