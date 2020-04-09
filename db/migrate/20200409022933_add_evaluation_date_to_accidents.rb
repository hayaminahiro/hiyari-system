class AddEvaluationDateToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :evaluation_date, :datetime
  end
end
