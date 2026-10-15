class CreateWeeklyPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :weekly_plans do |t|
      t.string :title
      t.integer :week
      t.text :notes
      t.text :reflect
      t.text :actions
      t.text :ideas

      t.timestamps
    end
  end
end
