class CreateAccidents < ActiveRecord::Migration[5.2]
  def change
    create_table :accidents do |t|
      t.boolean :which_accident
      t.string :reporter
      t.datetime :accident_datetime
      t.string :accident_senior
      t.string :accident_scene
      t.references :senior, foreign_key: true

      t.timestamps
    end
  end
end
