class AddSummary < ActiveRecord::Migration[5.0]
  def change

    create_table :summaries do |t|
      t.datetime :year
      t.timestamps
    end
  end
end
