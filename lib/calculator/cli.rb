require 'calculator/processor'

module Calculator
  class CLI
    EXIT_CHAR_REGEX = /^[q|\cD]$/

    def initialize
      @processor = Calculator::Processor.new
    end

    def run
      print "> "

      loop do
        line = gets
        exit if (line =~ EXIT_CHAR_REGEX) || line.nil?
        @processor.handle(line)
        print "> "
      end
    end
  end

end
