class AddStatusToApplicaiton < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :status, :integer
  end
end
