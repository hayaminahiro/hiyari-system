class AddAdminToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :admin, :boolean
  end
end
