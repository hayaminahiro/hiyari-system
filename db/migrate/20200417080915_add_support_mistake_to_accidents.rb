class AddSupportMistakeToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :support_mistake, :boolean
  end
end
