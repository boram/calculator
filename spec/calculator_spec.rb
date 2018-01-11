require 'calculator'
require 'pty'

RSpec.describe Calculator, "#run" do
  it "adds" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      enter("1", stdin, stdout)
      enter("2", stdin, stdout)
      expect_sum("3.0", stdin, stdout)
    end
  end

  def enter(value, stdin, stdout)
    stdin.puts value
    expect(stdout.gets.chomp).to match(/(?:> )?#{value}$/)
    stdout.gets
  end

  def expect_sum(value, stdin, stdout)
    stdin.puts "+"
    stdout.gets
    expect(stdout.gets.chomp).to match(/#{value}$/)
  end
end
