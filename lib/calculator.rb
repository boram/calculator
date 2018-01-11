class Calculator
  def initialize
    @stack = []
  end

  def run
    print "> "

    loop do
      line = gets.chomp

      if line =~ /^\+$/
        add
      else
        puts line
        @stack << line.to_f
      end

      print "> "
    end
  end

  private

  def add
    @stack = [@stack.sum]
    puts @stack.first
  end
end
