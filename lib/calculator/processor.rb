module Calculator
  class Processor
    OPERATORS_REGEX = /^[\+\-\*\/]$/
    VALUE_REGEX = /^\-?\d+\.?\d*?$/

    def initialize
      @stack = []
    end

    def handle(line)
      items = line.split(' ')
      validate(items)

      if items.last =~ OPERATORS_REGEX
        operator = items.pop
        push(items)
        reduce(operator)
      else
        puts items
        push(items)
      end
    end

    private

    def push(items)
      @stack += items.map(&:to_f)
    end

    def reduce(operator)
      if @stack.count <= 1
        message = case @stack.count
        when 0
          "Please enter at least two values before performing an operation."
        when 1
          "Please enter one more value before performing an operation."
        end
        raise Calculator::InsufficientStackError.new(message)
      end

      @stack = [@stack.inject(operator)]
      puts @stack.first
    end

    def validate(items)
      errored_values = []

      items.each do |item|
        next if VALUE_REGEX.match?(item) || OPERATORS_REGEX.match?(item)
        errored_values << item
      end

      if errored_values.any?
        stringified_values = errored_values.join(' ')

        message = if errored_values.count > 1
          "#{stringified_values} are not numbers or operators."
        else
          "#{stringified_values} is not a number or operator."
        end

        raise Calculator::InvalidEntryError.new(message)
      end
    end
  end
end
