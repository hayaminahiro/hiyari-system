class AddSuperiorELastToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_e_last, :string
  end
end
