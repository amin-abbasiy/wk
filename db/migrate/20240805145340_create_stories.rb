class CreateStories < ActiveRecord::Migration[7.1]
  def change
    create_table :stories do |t|
      t.text :nugget
      t.text :situation
      t.text :action
      t.text :result

      t.timestamps
    end
  end
end
