require 'calculator'
require 'calculator/processor'
require 'byebug'

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

        begin
          @processor.handle(line)
        rescue Calculator::InvalidEntryError => e
          puts e.message
        ensure
          print "> "
        end
      end
    end
  end
end
