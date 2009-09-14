class ManParser
  def self.parse(cmd)
    text = `man #{cmd}`
    description, options = parse_description(text)
    {:description => description.join(''), :options=>options}
  end

  private

  def self.parse_description(text)
    section = section('DESCRIPTION', text)
    
    in_option = false
    options = []
    description = []

    section[1..-1].each do |line|

      if start_of_option?(line)
        in_option = true
        options << [] #new option
      elsif line =~ /^\s*$/
        in_option = false
      end

      line = line.strip
      next if line.empty?

      if in_option
        options.last << line
      else
        description << line
      end
    end

    [description, options]
  end

  def self.section(name, text)
    in_section = false
    text.split("\n").map do |line|
      in_section = false if line =~ /^[A-Z]+$/
      in_section = true if line == name
      in_section ? line : nil
    end.compact
  end

  def self.start_of_option?(line)
    !!( line =~ /^\s+-+[\da-zA-Z]/)
  end
end