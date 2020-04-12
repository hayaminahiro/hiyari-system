class AddMeasuresCommentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :measures_comment, :string
  end
end
