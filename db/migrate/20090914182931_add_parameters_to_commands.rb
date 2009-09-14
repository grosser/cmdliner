class AddParametersToCommands < ActiveRecord::Migration
  def self.up
    add_column :commands, :parameter_1, :string
    add_column :commands, :parameter_2, :string
  end

  def self.down
    remove_column :commands, :parameter_1
    remove_column :commands, :parameter_2
  end
end
