class AddSuperiorDLastToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_d_last, :string
  end
end
