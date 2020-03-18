class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.string :worker_name
      t.string :worker_name_call
      t.string :sign_name
      t.integer :working_floor
      t.string :charge_senior
      t.boolean :working_flg, default: true
      t.references :facility, foreign_key: true

      t.timestamps
    end
  end
end
