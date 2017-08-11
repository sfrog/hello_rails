class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos, id: :string do |t|
      t.string :title, null: false
      t.text :content
      t.string :project_id, null: false
      t.integer :state, null: false, default: 0
      t.string :creator_id, null: false
      t.string :owner_id
      t.date :due_at, null: true, default: nil

      t.timestamps
    end
    add_index :todos, :project_id
  end
end
