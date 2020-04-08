class AddAccidentTimeToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :accident_time, :datetime
  end
end
