class AddDisplayToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :display, :boolean, default: true
  end
end
