class AddResultSeniorToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :result_senior, :string
  end
end
