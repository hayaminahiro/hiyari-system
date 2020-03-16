class CreateSeniors < ActiveRecord::Migration[5.2]
  def change
    create_table :seniors do |t|
      t.string :senior_name
      t.integer :floor
      t.string :charge_worker
      t.boolean :using_flg, default: true
      t.references :facility, foreign_key: true

      t.timestamps
    end
  end
end
