class AddReportingDateToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :reporting_date, :datetime
  end
end
