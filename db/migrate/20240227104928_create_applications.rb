class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :company_name
      t.string :position_title

      t.timestamps
    end
  end
end
