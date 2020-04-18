class AddImprovedSupportToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :improved_support, :boolean
  end
end
