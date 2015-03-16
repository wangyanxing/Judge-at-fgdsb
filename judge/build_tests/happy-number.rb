require './common'
require '../ruby/common'

class Test_happy_number < TestBase
  def initialize(name)
    super(name)
  end
  
  def happy?(n)
    @seen_numbers = Set.new
    @happy_numbers = Set.new
    
    return true if n == 1 # Base case
    return @happy_numbers.include?(n) if @seen_numbers.include?(n) # Use performance cache, and stop unhappy cycles
   
    @seen_numbers << n
    digit_squared_sum = n.to_s.each_char.inject(0) { |sum, c| sum + c.to_i**2 } # In Rails: n.to_s.each_char.sum { c.to_i**2 }
   
    if happy?(digit_squared_sum)
      @happy_numbers << n
      true # Return true
    else
      false # Return false
    end
  end

  def gen_tests
    @test_in, @test_out = [[]], []
    
    (1..100).each do |n|
      @test_in[0] << n
      @test_out << happy? n
    end
  end
end

Test_happy_number.new 'happy-number'