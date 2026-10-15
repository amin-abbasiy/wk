class AddMyFirstImpressionAndResultToInterviewChestSheets < ActiveRecord::Migration[7.1]
  def change
    add_column :interview_cheat_sheets, :my_first_impression, :text
    add_column :interview_cheat_sheets, :result, :text
  end
end
