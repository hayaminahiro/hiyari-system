class AddOauthExpiresAtToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :oauth_expires_at, :datetime
  end
end
