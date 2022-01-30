class AddProjectToEntries < ActiveRecord::Migration[5.0]
  def change
      add_column :entries, :project, :string
  end
end
