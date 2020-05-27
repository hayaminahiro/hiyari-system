class AddProviderToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :provider, :string
  end
end
