class AddSuperiorCToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_c, :string
  end
end
