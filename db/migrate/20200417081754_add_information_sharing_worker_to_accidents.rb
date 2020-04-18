class AddInformationSharingWorkerToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :information_sharing_worker, :boolean
  end
end
