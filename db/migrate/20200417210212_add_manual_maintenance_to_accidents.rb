class AddManualMaintenanceToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :manual_maintenance, :boolean
  end
end
