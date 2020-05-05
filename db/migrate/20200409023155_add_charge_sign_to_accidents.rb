class AddChargeSignToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :charge_sign, :string
  end
end
