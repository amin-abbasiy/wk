class AddPlaceToReflection < ActiveRecord::Migration[7.1]
  def change
    add_column :reflections, :place, :string
  end
end
