class AddResultWorkerToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :result_worker, :string
  end
end
