class AddSeizureToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :seizure, :boolean
  end
end
