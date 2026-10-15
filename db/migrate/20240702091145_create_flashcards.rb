class CreateFlashcards < ActiveRecord::Migration[7.1]
  def change
    create_table :flashcards do |t|
      t.text :content
      t.text :description
      t.integer :status
      t.integer :repetition

      t.timestamps
    end
  end
end
