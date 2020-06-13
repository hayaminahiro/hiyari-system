class AddAccountDeleteToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :account_delete, :boolean
  end
end
