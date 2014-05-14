#!usr/bin/env ruby

# Coordinate class that stores a lat/long pair 
class Coordinate
  attr_accessor :lat, :long

  # default value is invalid
  def initialize(lat="999", long="999")
    @lat = lat
    @long = long
  end

  def <=> other
    return 1 if @lat > other.lat
    return -1 if @lat < other.lat
    return @long <=> other.long
  end
  
  def == other
    return true if @lat == other.lat and @long == other.long
    return false
  end

  def to_s
    return "(" + @lat + "," + @long + ")"
  end
end


