class AddNatureToWeeklyPlan < ActiveRecord::Migration[7.1]
  def change
    add_column :weekly_plans, :nature, :integer
  end
end
