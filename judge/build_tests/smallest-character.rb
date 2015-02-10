require './common'
require '../ruby/common'

class Test_smallest_character < TestBase
  def initialize(name)
    super(name)
  end
  
  def smallest_character(str, c)
      str.chars.each do |ch|
          return ch if ch > c
      end
      str[0]
  end

  def add_test(size)
    str = (0...size).map { ('a'..'z').to_a.sample }.sort.join
    c = ('a'..'z').to_a.sample
    @test_in[0] << str
    @test_in[1] << c
    @test_out << smallest_character(str, c)
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []
    
    50.times do
      add_test(rand(1..30))
    end

    50.times do
      add_test(rand(70..100))
    end

    100.times do
      add_test(rand(500..1000))
    end
  end
end

Test_smallest_character.new 'smallest-character'