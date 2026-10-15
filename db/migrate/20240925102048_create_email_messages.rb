class CreateEmailMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :email_messages do |t|
      t.text :message
      t.text :response

      t.timestamps
    end
  end
end
