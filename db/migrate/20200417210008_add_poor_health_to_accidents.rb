class AddPoorHealthToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :poor_health, :boolean
  end
end
