#!/usr/bin/env ruby

# checks if a file exists and is readable. 
# this is for the data file that is passed in
def validFile? filename
  if !filename.kind_of? String
    return false
  elsif File.exists? filename
    return File.readable? filename
  else
    return false
  end
end

# checks to see if the object is a float. 
# this is used for making sure our data file is well-formed
def float?(object)
    return true if Float(object)
  rescue 
    return false
end


