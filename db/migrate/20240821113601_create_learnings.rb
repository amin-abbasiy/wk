class CreateLearnings < ActiveRecord::Migration[7.1]
  def change
    create_table :learnings do |t|
      t.string :title
      t.text :concepts
      t.boolean :finished

      t.timestamps
    end
  end
end
