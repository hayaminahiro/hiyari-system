class AddWellKnownToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :well_known, :boolean
  end
end
