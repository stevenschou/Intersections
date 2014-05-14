require 'test/unit'
require 'coordinate'

class TestCoordinateClass < Test::Unit::TestCase
  def testCoordinateComparison
    coo1 = Coordinate.new(5,8)
    coo2 = Coordinate.new(4,9)
    coo3 = Coordinate.new(6,7)
    coo4 = Coordinate.new(4,10)
    coo5 = Coordinate.new(4,10)

    result1 = coo1 <=> coo2
    assert_equal result1, 1
    
    result2 = coo2 <=> coo3
    assert_equal result2, -1
    
    result3 = coo2 <=> coo4
    assert_equal result3, -1
    
    result4 = coo4 <=> coo5
    assert_equal result4, 0    
  end
end 
