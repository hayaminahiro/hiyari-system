class AddWorkerEducationToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :worker_education, :boolean
  end
end
