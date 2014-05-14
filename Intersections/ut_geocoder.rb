require 'test/unit'
require 'geocoder'

class TestGeocoder < Test::Unit::TestCase
  def testGeocodes
    organizeData "sf_street_data.txt" 
    # found
    result = geocode "1", "brotherhood"
    assert_equal result.size, 4 

    result = geocode "ElizAbeth", "Douglass"
    assert_equal result.size, 1   
 
    result = geocode "victoria", "urbano"
    assert_equal result.size, 2   
 
    #not found
    result = geocode "haha", "yay"
    assert_equal result, nil

    result = geocode "1", "front"
    assert_equal result, nil

    result = geocode "pine", "california"
    assert_equal result, nil
    
    result = geocode "pine", "pine"
    assert_equal result, nil    
  end

end
