class Banner
  def initialize(message, width)
    @message = message
    @width = width <= MAX_WIDTH ? width : MAX_WIDTH
  end

  def to_s
    [horizontal_rule, empty_line, message_lines, empty_line, horizontal_rule].join("\n")
  end

  private

  MAX_WIDTH = 76

  def horizontal_rule
    "+#{'-' * (@width + 2)}+"
  end

  def empty_line
    "|#{' ' * (@width + 2)}|"
  end

  def message_lines
    temp_message = @message.clone
    lines = []

    lines << "| #{temp_message.slice!(0, @width)} |" until temp_message == ''
    lines << "|#{' ' * @width}|" if lines.empty?

    if lines.last.length - 4 < @width
      lines.last.insert(-2, ' ' * (@width - (lines.last.length - 4)))
    end

    lines.join("\n")
  end
end

# test cases
banner = Banner.new('To boldly go where no one has gone before.', 5)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('', 200)
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+
