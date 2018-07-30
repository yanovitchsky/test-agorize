class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_index :skills, :parent_id
    add_foreign_key :skills, :skills, column: :parent_id, primary_key: :id
  end
end
