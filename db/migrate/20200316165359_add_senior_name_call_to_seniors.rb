class AddSeniorNameCallToSeniors < ActiveRecord::Migration[5.2]
  def change
    add_column :seniors, :senior_name_call, :string
  end
end
