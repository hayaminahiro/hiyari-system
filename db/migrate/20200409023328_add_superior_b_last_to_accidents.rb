class AddSuperiorBLastToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_b_last, :string
  end
end
