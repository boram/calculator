class Calculator
  OPERATORS_REGEX = /^[\+\-\*\/]$/

  def initialize
    @stack = []
  end

  def run
    print "> "

    loop do
      line = gets.chomp

      if line =~ OPERATORS_REGEX
        reduce(line)
      else
        puts line
        @stack << line.to_f
      end

      print "> "
    end
  end

  private

  def reduce(operator)
    @stack = [@stack.inject(operator)]
    puts @stack.first
  end
end
