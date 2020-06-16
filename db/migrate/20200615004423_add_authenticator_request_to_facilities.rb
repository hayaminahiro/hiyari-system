class AddAuthenticatorRequestToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :authenticator_request, :boolean
  end
end
