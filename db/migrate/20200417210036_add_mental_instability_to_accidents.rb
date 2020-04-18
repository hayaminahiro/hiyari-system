class AddMentalInstabilityToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :mental_instability, :boolean
  end
end
