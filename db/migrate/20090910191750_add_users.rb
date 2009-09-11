class AddUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null=>false
      t.string :identifier, :null=>false, :unique=>true
      t.string :email, :uniq=>true
      t.string :website
      t.boolean :admin, :default=>false, :null=>false
      t.timestamps
    end

    # enforce uniqueness
    add_index :users, :name, :unique => true
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
