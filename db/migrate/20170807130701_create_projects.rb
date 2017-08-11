class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :string do |t|
      t.string :name, null: false
      t.string :team_id, null: false

      t.timestamps
    end
    add_index :projects, :team_id
  end
end
