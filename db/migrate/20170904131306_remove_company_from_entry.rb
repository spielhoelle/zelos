class RemoveCompanyFromEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :company
  end
end
