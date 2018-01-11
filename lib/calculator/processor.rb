module Calculator
  class Processor
    OPERATORS_REGEX = /^[\+\-\*\/]$/

    def initialize
      @stack = []
    end

    def handle(line)
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
end
