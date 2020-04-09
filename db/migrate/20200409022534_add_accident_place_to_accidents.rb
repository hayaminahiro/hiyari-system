class AddAccidentPlaceToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :accident_place, :string
  end
end
