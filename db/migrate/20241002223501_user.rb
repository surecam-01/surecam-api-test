class User < ActiveRecord::Migration[7.0]
  create_table :users do |t|
    ## Database authenticatable
    t.string :username,           null: false, default: ""
    t.string :email,              null: false, default: ""
    t.string :password_digest,    null: false, default: ""


    t.string :user_type,          null: false


    t.timestamps null: false
  end

  add_index :users, :username,             unique: true
  add_index :users, :email,                unique: true
  add_index :users, :user_type

end
