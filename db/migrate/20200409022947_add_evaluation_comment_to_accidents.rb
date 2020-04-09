class AddEvaluationCommentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :evaluation_comment, :string
  end
end
