class CreateHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :histories do |t|
      t.string :owner
      t.integer :owner_id
      t.integer :version
      t.json :data

      t.timestamps
    end
    add_index :histories, :owner_id
    add_index :histories, :version
  end
end
