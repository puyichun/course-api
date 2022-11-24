class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.belongs_to :chapter, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
