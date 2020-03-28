class AddAccidentFloorToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :accident_floor, :integer
  end
end
