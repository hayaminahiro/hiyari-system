class AddSuperiorDToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_d, :string
  end
end
