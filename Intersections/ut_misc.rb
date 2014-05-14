require 'test/unit'
require 'misc'

class TestFloatFunction < Test::Unit::TestCase
  def testFloat
    result = float? 3.2
    assert_equal result, true
    result2 = float? 5
    assert_equal result2, true
  end

  def testNonFloat
    result = float? "abc"
    assert_equal result, false
  end

  def testNil
    result = float? nil
    assert_equal result, false
  end
end

class TestValidFile < Test::Unit::TestCase
  def testValidFile
    result = validFile? "misc.rb"
    assert_equal result, true
  end
  def testInvalidFileMissing
    result = validFile? "blah.blah"
    assert_equal result, false
  end
  def testInvalidFileUnreadable
    result = validFile? "unreadable.txt"
    assert_equal result, false
  end
  def testNil
    result = validFile? nil
    assert_equal result, false
  end
  def testInvalidParam
    result = validFile? 1
    assert_equal result, false
  end
end 
