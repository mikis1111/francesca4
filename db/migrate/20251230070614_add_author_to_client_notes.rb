class AddAuthorToClientNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :client_notes, :author, :string
  end
end
