class AddSuperiorCommentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :superior_comment, :string
  end
end
