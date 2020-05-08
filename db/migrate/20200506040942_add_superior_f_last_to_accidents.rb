class AddSuperiorFLastToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_f_last, :string
  end
end
