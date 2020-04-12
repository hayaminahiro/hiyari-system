class AddActiveToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :active, :string
  end
end
