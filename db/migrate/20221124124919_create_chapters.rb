class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.belongs_to :course, null: false, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
