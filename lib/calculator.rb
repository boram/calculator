class Calculator
  EXIT_CHAR_REGEX = /^[q|\cD]$/
  OPERATORS_REGEX = /^[\+\-\*\/]$/

  def initialize
    @stack = []
  end

  def run
    print "> "

    loop do
      line = gets
      exit if (line =~ EXIT_CHAR_REGEX) || line.nil?
      process(line)
      print "> "
    end
  end

  private

  def process(line)
    items = line.split(' ')

    if items.last =~ OPERATORS_REGEX
      operator = items.pop
      push(items)
      reduce(operator)
    else
      puts items
      push(items)
    end
  end

  def push(items)
    @stack += items.map(&:to_f)
  end

  def reduce(operator)
    @stack = [@stack.inject(operator)]
    puts @stack.first
  end
end
