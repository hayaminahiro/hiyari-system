class AddAccidentResultCommentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :accident_result_comment, :string
  end
end
