namespace :cl do
  desc "x"
  task :generate_commands  => :environment do
    ManParser.available_commands.each do |cmd|
      next if Command.find_by_name(cmd)
      data = ManParser.parse(cmd)
      cmd = Command.new(:name=>cmd, :description => data[:description])
      data[:options].each do |option|
        cmd.options.build(option)
      end
      cmd.save!
      puts "created command #{cmd.name}"
    end
  end
end