class AddEnvironmentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :environment, :boolean
  end
end
