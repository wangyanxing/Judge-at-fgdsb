require './common'
require '../ruby/common'
require 'set'

class Test_happy_number < TestBase
  def initialize(name)
    super(name)
  end
  
  def happy?(n)
    return true if n == 1 # Base case
    return @happy_numbers.include?(n) if @seen_numbers.include?(n)
   
    @seen_numbers << n
    digit_squared_sum = n.to_s.each_char.inject(0) { |sum, c| sum + c.to_i**2 }
   
    if happy?(digit_squared_sum)
      @happy_numbers << n
      return true
    else
      return false
    end
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    (1..100).each do |n|
      @seen_numbers = Set.new
      @happy_numbers = Set.new
      @test_in[0] << n
      @test_out << happy?(n)
    end

    (1000..1500).each do |n|
      @seen_numbers = Set.new
      @happy_numbers = Set.new
      @test_in[0] << n
      @test_out << happy?(n)
    end

    (980000..982123).each do |n|
      @seen_numbers = Set.new
      @happy_numbers = Set.new
      @test_in[0] << n
      @test_out << happy?(n)
    end
  end
end

Test_happy_number.new 'happy-number'