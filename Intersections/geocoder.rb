#!/usr/bin/env ruby

require "coordinate"
require "misc"
require "singleton"

# Logger singleton class that will log things to "logs.txt"
class Logger
  include Singleton

  def initialize
    time = Time.new
    @log = File.open("logs.txt", "a")
    @log.write("Begin Logging at: " + time.inspect + "\n")
  end

  def log string
    @log.write(string + "\n") 
  end

  def logError string
    @log.write("!ERROR! " + string + " !ERROR!\n")
  end

  def end
    time = Time.new
    @log.write("End Logging at: " + time.inspect + "\n")
    @log.close
  end  
end

$result_hash           # global variable for our resulting hash 

# this function takes a file and builds our resulting hash from which we can query from
def organizeData data_filename
  if validFile? data_filename
  else
    Logger.instance.logError("The file " + data_filename + " is invalid.")
    raise ArgumentError, "The file is invalid. Make sure the file exists and is readable"
  end

  data_file = File.open(data_filename)

  data_hash = Hash.new
  data_arr = []
  $result_hash = Hash.new

  data_file.each do |segment|
    value = segment.split("\t") # tab is our delimeter
    if value.size != 3
      Logger.instance.logError("The segment " + segment + " is not in the format [lat] [long] [streetname] delimited by tabs.")
    else
      if float?(value[0]) and float?(value[1])
        data_hash[Coordinate.new(value[0],value[1])] = value[2].chomp
      else
        Logger.instance.logError("Either " + value[0] + " or " + value[1] + " is not a float.")
      end
    end
  end

  data_file.close

  sorted_data = data_hash.sort{|a,b| a[0] <=> b[0]}
  
  cur_coo = Coordinate.new
  sorted_data << [cur_coo,"END"] # a special marker at the end so we know we have looked at all the elements
 
  sorted_data.each do |coo|
    if coo[0] != cur_coo
      if data_arr.size > 1
        combo = data_arr.combination(2).to_a # get all possible pairs
        combo.each do |s1,s2|
          if s1 < s2
            key = s1.capitalize + "_" + s2.capitalize # capitalize for case-insensitive search
            Logger.instance.log("Added key " + key)
          elsif s2 < s1
            key = s2.capitalize + "_" + s1.capitalize
            Logger.instance.log("Added key " + key)
          else
            next
          end
          if $result_hash.has_key? key
            a = $result_hash[key]
            $result_hash[key] << cur_coo if !a.index cur_coo
          else
            $result_hash[key] = [cur_coo]
          end
        end
      end
      data_arr.clear
      data_arr << coo[1]
      cur_coo = coo[0]
    else
      data_arr << coo[1]
    end
  end
end

def geocode(street1, street2)
  return $result_hash[street1.capitalize + "_" + street2.capitalize] if street1 < street2
  return $result_hash[street2.capitalize + "_" + street1.capitalize] if street2 < street1 
end
