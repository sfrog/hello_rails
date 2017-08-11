class CreateAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :accesses, id: :string do |t|
      t.string :user_id, null: false
      t.string :accessable_id, null: false
      t.string :accessable_type, null: false
      t.integer :access_level, null: false

      t.timestamps
    end
    add_index :accesses, :user_id
    add_index :accesses, :accessable_id
  end
end
