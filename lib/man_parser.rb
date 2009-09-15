class ManParser
  def self.parse(cmd)
    text = `man #{cmd}`
    sections = sections(text)
    puts sections.inspect
    description, options = parse_description(sections['DESCRIPTION'])
    {:description => description.join(''), :options=>options, :sections=>sections}
  end

  private

  def self.parse_description(text)
    in_option = false
    options = []
    description = []

    text[1..-1].each do |line|

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

  def self.sections(text)
    name = 'OUT_OF_SECTION'
    sections = Hash.new([])

    text.split("\n").each do |line|
      name = line if line =~ /^[A-Z]+$/
      sections[name] += [line]
    end

    sections
  end

  def self.start_of_option?(line)
    !!( line =~ /^\s+-+[\da-zA-Z]/)
  end
end