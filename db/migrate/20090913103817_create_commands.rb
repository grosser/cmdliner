class CreateCommands < ActiveRecord::Migration
  def self.up
    create_table :commands do |t|
      t.string :name, :null=>false
      t.text :description, :null=>false
      t.boolean :mac_only, :default=>false, :null=>false
      t.timestamps
    end

    # enforce uniqueness
    add_index :commands, :name, :unique => true
  end

  def self.down
    drop_table :commands
  end
end
