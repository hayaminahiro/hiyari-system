class AddResultCommentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :result_comment, :string
  end
end
