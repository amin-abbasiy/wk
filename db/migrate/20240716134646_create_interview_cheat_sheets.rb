class CreateInterviewCheatSheets < ActiveRecord::Migration[7.1]
  def change
    create_table :interview_cheat_sheets do |t|
      t.datetime :date
      t.string :location
      t.string :company
      t.string :positon
      t.text :interviewers
      t.text :company_info
      t.text :my_pitch
      t.text :accomplishments_skills
      t.text :reason_about_position
      t.text :my_questions
      t.text :predicted_question_answers

      t.timestamps
    end
  end
end
