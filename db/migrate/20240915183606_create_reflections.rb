class CreateReflections < ActiveRecord::Migration[7.1]
  def change
    create_table :reflections do |t|
      t.string :title
      t.integer :nature
      t.text :content
      t.text :action

      t.timestamps
    end
  end
end
