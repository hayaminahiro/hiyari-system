class AddNotEnoughAssessmentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :not_enough_assessment, :boolean
  end
end
