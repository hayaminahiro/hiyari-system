class AddNotEnoughSkillsToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :not_enough_skills, :boolean
  end
end
