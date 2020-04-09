class AddFamilyCommentToAccidents < ActiveRecord::Migration[5.2]
  def change
    add_column :accidents, :family_comment, :string
  end
end
