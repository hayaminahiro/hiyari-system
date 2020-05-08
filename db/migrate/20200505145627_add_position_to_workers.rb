class AddPositionToWorkers < ActiveRecord::Migration[5.2]
  def change
    add_column :workers, :position, :integer
  end
end
