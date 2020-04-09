class AddMeasuresToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :measures, :string
  end
end
