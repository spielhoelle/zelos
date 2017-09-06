class AddOfferToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :is_offer, :boolean, default: false
    add_column :entries, :valid_until, :datetime
  end
end
