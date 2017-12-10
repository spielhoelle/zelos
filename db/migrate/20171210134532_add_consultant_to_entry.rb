class AddConsultantToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :is_consultant, :boolean
  end
end
