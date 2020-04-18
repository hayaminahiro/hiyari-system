class AddInformationSharingToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :information_sharing, :boolean
  end
end
