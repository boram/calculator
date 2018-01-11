require 'calculator'
require 'pty'

RSpec.describe Calculator, "#run" do
  context "adds values" do
    it "entered in sequence" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        enter("1", stdin, stdout)
        enter("2", stdin, stdout)
        expect_output("+", "3.0", stdin, stdout)
      end
    end

    it "entered on one line" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        stdin.puts "1 2 +"
        clear_echoed_output(stdout)
        expect(stdout.gets.chomp).to match(/3\.0$/)
      end
    end
  end

  context "subtracts values" do
    it "entered in sequence" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        enter("2", stdin, stdout)
        enter("1", stdin, stdout)
        expect_output("-", "1.0", stdin, stdout)
      end
    end

    it "entered on one line" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        stdin.puts "2 1 -"
        clear_echoed_output(stdout)
        expect(stdout.gets.chomp).to match(/1\.0$/)
      end
    end
  end

  context "multiplies values" do
    it "entered in sequence" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        enter("2", stdin, stdout)
        enter("3", stdin, stdout)
        expect_output("*", "6.0", stdin, stdout)
      end
    end

    it "entered on one line" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        stdin.puts "2 3 *"
        clear_echoed_output(stdout)
        expect(stdout.gets.chomp).to match(/6\.0$/)
      end
    end
  end

  context "divides values " do
    it "entered in sequence" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        enter("12", stdin, stdout)
        enter("3", stdin, stdout)
        expect_output("/", "4.0", stdin, stdout)
      end
    end

    it "entered on one line" do
      PTY.spawn('bin/calculator') do |stdout, stdin, pid|
        stdin.puts "12 3 /"
        clear_echoed_output(stdout)
        expect(stdout.gets.chomp).to match(/4\.0$/)
      end
    end
  end

  it "exits when 'q' is entered" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      enter("q", stdin, stdout)
      sleep 0.1
      expect(PTY.check(pid)).to be_a_kind_of(Process::Status)
    end
  end

  xit "exits when end of file (\cD) is entered" do
    PTY.spawn('bin/calculator') do |stdout, stdin, pid|
      stdin.puts "\cD"
      sleep 0.1
      expect(PTY.check(pid)).to be_a_kind_of(Process::Status)
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

  def clear_echoed_output(stdout)
    stdout.gets
  end
end
