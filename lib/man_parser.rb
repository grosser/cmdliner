class ManParser
  def self.parse(cmd)
    text = `man #{cmd}`
    sections = sections(text)
    description, options = parse_description(sections['DESCRIPTION'])
    options = parse_options(options)
    {:description => description.map(&:strip).join(''), :options=>options, :sections=>sections}
  end

  private

  def self.parse_options(options)
    options.map{|option| parse_option(option) }
  end

  def self.parse_option(option)
    if option.join(' ') =~ /-(\w+), --(\w+)(.*)/
      {:name=>$1, :alias=>$2, :description=>$3.strip}
    end
  end

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

      next if line.strip.empty?

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