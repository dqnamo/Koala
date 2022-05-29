class AddSessionIdToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :session_id, :string
    add_index :notes, :session_id
  end
end
