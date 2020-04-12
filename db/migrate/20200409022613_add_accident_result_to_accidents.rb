class AddAccidentResultToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :accident_result, :integer, default: 0
  end
end
