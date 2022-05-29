class AddUserIdToNotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :notes, :user, index: true
  end
end
