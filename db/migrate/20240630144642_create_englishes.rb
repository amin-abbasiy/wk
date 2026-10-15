class CreateEnglishes < ActiveRecord::Migration[7.1]
  def change
    create_table :englishes do |t|
      t.string :word
      t.text :definition
      t.timestamps
    end
  end
end
