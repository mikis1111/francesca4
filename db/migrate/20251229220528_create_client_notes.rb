class CreateClientNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :client_notes do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
