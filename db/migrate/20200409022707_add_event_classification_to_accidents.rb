class AddEventClassificationToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :event_classification, :integer
  end
end
