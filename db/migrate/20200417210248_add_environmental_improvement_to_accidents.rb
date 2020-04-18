class AddEnvironmentalImprovementToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :environmental_improvement, :boolean
  end
end
