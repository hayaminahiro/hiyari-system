class AddChangeMeasuresToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :change_measures, :string
  end
end
