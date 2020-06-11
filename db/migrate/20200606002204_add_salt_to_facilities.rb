class AddSaltToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :salt, :string
  end
end
