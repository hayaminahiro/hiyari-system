class AddSuperiorFToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_f, :string
  end
end
