class AddAuthenticatorCheckToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :authenticator_check, :boolean, default: true
  end
end
