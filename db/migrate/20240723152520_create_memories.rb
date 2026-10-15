class CreateMemories < ActiveRecord::Migration[7.1]
  def change
    create_table :memories do |t|
      t.string :title
      t.text :content
      t.text :feeling
      t.text :lessons
      t.text :use_cases
      t.text :channeling_ways
      t.text :dangers
      t.text :conclusions
      t.integer :repeated

      t.timestamps
    end
  end
end
