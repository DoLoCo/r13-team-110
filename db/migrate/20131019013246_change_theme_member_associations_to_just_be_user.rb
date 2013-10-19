class ChangeThemeMemberAssociationsToJustBeUser < ActiveRecord::Migration
  def change
    rename_column :ideas, :theme_member_id, :user_id
    rename_column :comments, :theme_member_id, :user_id
  end
end
