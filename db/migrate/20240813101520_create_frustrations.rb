class CreateFrustrations < ActiveRecord::Migration[7.1]
  def change
    create_table :frustrations do |t|
      t.string :title
      t.text :content
      t.text :trash_them
      t.text :reasons
      t.text :channeling_techniques
      t.text :created_purposes
      t.text :goals_for_purposes
      t.text :action_plan
      t.text :emotions_after_action
      t.text :result_of_emotions
      t.text :resule_of_action
      t.string :catchphrase

      t.timestamps
    end
  end
end
