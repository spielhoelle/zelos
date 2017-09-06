class AddPrivateNoticeToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :private_note, :text
  end
end
