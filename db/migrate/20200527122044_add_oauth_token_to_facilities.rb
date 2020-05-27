class AddOauthTokenToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :oauth_token, :string
  end
end
