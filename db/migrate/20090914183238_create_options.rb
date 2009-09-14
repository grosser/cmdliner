class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :name, :null=>false
      t.string :alias
      t.integer :command_id, :null=>false
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
