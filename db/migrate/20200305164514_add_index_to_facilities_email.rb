class AddIndexToFacilitiesEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :facilities, :email, unique: true
  end
end
