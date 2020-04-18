class AddAgingToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :aging, :boolean
  end
end
