class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :string do |t|
      t.string :name, null: false
      t.string :avatar

      t.timestamps
    end
  end
end
