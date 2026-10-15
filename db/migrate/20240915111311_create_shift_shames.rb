class CreateShiftShames < ActiveRecord::Migration[7.1]
  def change
    create_table :shift_shames do |t|
      t.text :emotion_behind_shame
      t.text :seperate_people_story
      t.text :shift_to_appriciaton
      t.text :uncover_emotion_root
      t.text :realign_with_values

      t.timestamps
    end
  end
end
