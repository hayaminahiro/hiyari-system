class CreateSeniorWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :senior_workers do |t|
      t.references :worker, index: true, foreign_key: true
      t.references :senior, index: true, foreign_key: true

      t.timestamps
    end
  end
end
