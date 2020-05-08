class AddSuperiorEToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_e, :string
  end
end
