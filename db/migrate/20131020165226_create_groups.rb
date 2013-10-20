class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :theme, index: true
      t.string :title
      t.string :color

      t.timestamps
    end
  end
end
