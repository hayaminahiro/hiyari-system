class AddWorkAttitudeToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :work_attitude, :boolean
  end
end
