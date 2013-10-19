class AddThemeMemberIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :theme_member_id, :integer, null: false
    add_index :comments, :theme_member_id
  end
end
