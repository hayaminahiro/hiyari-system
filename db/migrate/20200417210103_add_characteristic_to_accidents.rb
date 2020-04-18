class AddCharacteristicToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :characteristic, :boolean
  end
end
