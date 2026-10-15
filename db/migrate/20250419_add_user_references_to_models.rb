class AddUserReferencesToModels < ActiveRecord::Migration[7.1]
  def change
    # Add user references to all models with default user_id set to 1
    add_reference :email_messages, :user, null: false, foreign_key: true, default: 1
    add_reference :applications, :user, null: false, foreign_key: true, default: 1
    add_reference :auto_suggestions, :user, null: false, foreign_key: true, default: 1
    add_reference :comments, :user, null: false, foreign_key: true, default: 1
    add_reference :flashcards, :user, null: false, foreign_key: true, default: 1
    add_reference :frustrations, :user, null: false, foreign_key: true, default: 1
    add_reference :histories, :user, null: false, foreign_key: true, default: 1
    add_reference :interview_cheat_sheets, :user, null: false, foreign_key: true, default: 1
    add_reference :learnings, :user, null: false, foreign_key: true, default: 1
    add_reference :memories, :user, null: false, foreign_key: true, default: 1
    add_reference :my_offers, :user, null: false, foreign_key: true, default: 1
    add_reference :reflections, :user, null: false, foreign_key: true, default: 1
    add_reference :shift_shames, :user, null: false, foreign_key: true, default: 1
    add_reference :stories, :user, null: false, foreign_key: true, default: 1
    add_reference :tasks, :user, null: false, foreign_key: true, default: 1
    add_reference :topics, :user, null: false, foreign_key: true, default: 1
    add_reference :weekly_plans, :user, null: false, foreign_key: true, default: 1
    add_reference :englishes, :user, null: false, foreign_key: true, default: 1
  end
end
