class AddGoogleSecretToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :google_secret, :string
  end
end