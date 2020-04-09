class AddDepartmentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :department, :string
  end
end
