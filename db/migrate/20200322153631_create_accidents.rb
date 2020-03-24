class CreateAccidents < ActiveRecord::Migration[5.2]
  def change
    create_table :accidents do |t|
      t.string :which_accident
      t.string :reporter
      t.datetime :accident_datetime, default: Time.zone.parse('2020-04-01 07:30:00')
      t.string :accident_senior
      t.string :accident_scene
      t.references :senior, foreign_key: true

      t.timestamps
    end
  end
end
