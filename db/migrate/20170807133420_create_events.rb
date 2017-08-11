class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :type, null: false
      t.string :actor_id, null: false
      t.string :resource_id, null: false
      t.string :resource_type, null: false
      t.string :project_id, null: false
      t.string :team_id, null: false
      t.string :action, null: false
      t.string :value
      t.string :old_value

      t.timestamps
    end
    add_index :events, :actor_id
    add_index :events, :project_id
    add_index :events, :team_id
    add_index :events, :resource_id
  end
end
