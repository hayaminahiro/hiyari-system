class AddRememberDigestToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :remember_digest, :string
  end
end
