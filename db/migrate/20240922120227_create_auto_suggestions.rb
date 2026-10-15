class CreateAutoSuggestions < ActiveRecord::Migration[7.1]
  def change
    create_table :auto_suggestions do |t|
      t.string :idea
      t.text :faith
      t.text :plan
      t.text :action
      t.text :persistence

      t.timestamps
    end
  end
end
