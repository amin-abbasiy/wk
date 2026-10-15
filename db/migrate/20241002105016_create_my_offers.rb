class CreateMyOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :my_offers do |t|
      t.string :title
      t.text :story
      t.text :present

      t.timestamps
    end
  end
end
