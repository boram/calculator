require 'calculator'
require 'pty'

RSpec.describe Calculator, "#run" do
  it "adds" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      enter("1", stdin, stdout)
      enter("2", stdin, stdout)
      expect_output("+", "3.0", stdin, stdout)
    end
  end

  it "subtracts" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      enter("2", stdin, stdout)
      enter("1", stdin, stdout)
      expect_output("-", "1.0", stdin, stdout)
    end
  end

  it "multiplies" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      enter("2", stdin, stdout)
      enter("3", stdin, stdout)
      expect_output("*", "6.0", stdin, stdout)
    end
  end

  it "divides" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      enter("12", stdin, stdout)
      enter("3", stdin, stdout)
      expect_output("/", "4.0", stdin, stdout)
    end
  end

  def enter(value, stdin, stdout)
    stdin.puts value
    expect(stdout.gets.chomp).to match(/(?:> )?#{value}$/)
    stdout.gets
  end

  def expect_output(operator, value, stdin, stdout)
    stdin.puts operator
    stdout.gets
    expect(stdout.gets.chomp).to match(/#{value}$/)
  end
end
