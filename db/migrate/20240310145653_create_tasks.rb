class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :weekly_plan, null: false, foreign_key: true
      t.string :name
      t.integer :interval
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.integer :status
      t.text :feelings

      t.timestamps
    end
  end
end
