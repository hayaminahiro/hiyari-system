class AddFacilityJudgeToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :facility_judge, :integer
  end
end
