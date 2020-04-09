class AddSuperiorALastToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_a_last, :string
  end
end
