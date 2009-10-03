class AddArgumentToOptions < ActiveRecord::Migration
  def self.up
    add_column :options, :argument, :string
  end

  def self.down
    remove_column :options, :argument
  end
end
