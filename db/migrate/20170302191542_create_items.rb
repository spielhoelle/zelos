class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :entry, foreign_key: true
      t.text :name
      t.integer :price
      t.timestamps
    end
  end
end
