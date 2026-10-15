class AddJdAndFeedbackToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :job_description, :text
    add_column :applications, :feedback, :text
  end
end
