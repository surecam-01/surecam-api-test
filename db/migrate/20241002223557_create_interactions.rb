class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.string  :type
      t.string  :title, :null => true
      t.text    :raw
      t.text    :sanitized
      t.integer :user_id
      t.integer :parent_interaction_id, :null => true
      t.timestamps
    end
    add_index :interactions, :type
    add_foreign_key :interactions, :users
  end
end
