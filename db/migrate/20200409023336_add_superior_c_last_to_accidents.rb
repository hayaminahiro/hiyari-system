class AddSuperiorCLastToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_c_last, :string
  end
end
