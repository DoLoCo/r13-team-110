class AddGroupIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :group_id, :integer
    add_index :ideas, :group_id
  end
end
