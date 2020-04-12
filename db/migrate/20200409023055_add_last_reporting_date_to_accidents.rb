class AddLastReportingDateToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :last_reporting_date, :datetime
  end
end
