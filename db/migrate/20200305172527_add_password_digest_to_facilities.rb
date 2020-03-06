class AddPasswordDigestToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :password_digest, :string
  end
end
