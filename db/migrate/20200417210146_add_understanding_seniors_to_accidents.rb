class AddUnderstandingSeniorsToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :understanding_seniors, :boolean
  end
end
