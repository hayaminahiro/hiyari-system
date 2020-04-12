class AddOtherActivitySceneToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :other_activity_scene, :string
  end
end
