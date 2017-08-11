class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments, id: :string do |t|
      t.text :content, null: false
      t.string :user_id, null: false
      t.string :commentable_id, null: false
      t.string :commentable_type, null: false

      t.timestamps
    end
    add_index :comments, :commentable_id
  end
end
