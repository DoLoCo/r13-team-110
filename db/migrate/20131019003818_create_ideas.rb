class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :content
      t.belongs_to :theme, index: true
      t.belongs_to :theme_member, index: true

      t.timestamps
    end
  end
end
