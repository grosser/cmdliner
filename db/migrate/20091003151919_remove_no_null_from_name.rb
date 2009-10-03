class RemoveNoNullFromName < ActiveRecord::Migration
  def self.up
    change_column :options, :name, :string, :null => true
  end

  def self.down
    change_column :options, :name, :string, :null => false
  end
end
