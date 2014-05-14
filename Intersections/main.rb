#!/usr/bin/env ruby

require 'geocoder'

# command line interface for our geocoder
while true
  puts "Enter a command (type help for a list of commands):"
  command = $stdin.gets.chomp
  case command
    when "help"
      puts "Commands | Description"
      puts "------------------------------------------------------------"
      puts "loadfile | load the data file"
      puts "geocode  | get the geocode of an intersection of two streets"
      puts "quit     | quits the application" 
      puts "------------------------------------------------------------"
    when "loadfile" # loads the data file for our geocoder
      puts "Enter the file path to the data"
      filepath = $stdin.gets.chomp
      organizeData filepath
      Logger.instance.log("LOADFILE:  Successfully loaded " + filepath)
    when "geocode"
      if !$result_hash #we need to load a data file first!
        puts "please load a data file before querying for a geocode"
        Logger.instance.logError("GEOCODE: Please load a file!")
      else
        puts "Enter the first street name"
        s1 = $stdin.gets.chomp
        puts "Enter the second street name"
        s2 = $stdin.gets.chomp
        if s1 == s2
          puts "Please enter different street names."
        else
          result = geocode s1, s2
          if result
            puts result
            result.each do |coordinate| 
              Logger.instance.log("GEOCODE: " + s1 + "," + s2 + " => " + coordinate.to_s)
            end
          else
            puts "Geocode not found. There is no intersection between these roads."
            Logger.instance.log("GEOCODE: " + s1 + "," + s2 + " => nil")
          end
        end
      end
    when "quit"
      Logger.instance.end
      exit
  else
    puts "Invalid command."
  end
end
