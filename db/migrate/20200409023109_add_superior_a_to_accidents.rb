class AddSuperiorAToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_a, :string
  end
end
