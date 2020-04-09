class AddAccidentWorkerToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :accident_worker, :string
  end
end
