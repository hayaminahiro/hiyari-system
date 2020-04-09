class AddOtherEventToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :other_event, :string
  end
end
