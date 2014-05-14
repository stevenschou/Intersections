Steven Chou 
<stevenschou@gmail.com>

********************************************************************************
 The Problem
********************************************************************************

Given a file of street points, can we write an efficient function to 
return a latitude, longitude pair given an intersection of street names?

********************************************************************************
 Usage
********************************************************************************

ruby main.rb

This will give a command line session where you can load the file and get the
geocode of an intersection of street names. You must load a file before asking
for a geocode! For example:

 *** Loading the file ***

Enter a command (type help for a list of commands):
geocode
please load a data file before querying for a geocode
Enter a command (type help for a list of commands):
loadfile
Enter the file path to the data
sf_street_data.txt

 *** Getting a geocode ***

Enter a command (type help for a list of commands):
geocode
Enter the first street name
1
Enter the second street name
brotherhood
(37.712689,-122.471337)
(37.712693,-122.47114)
(37.712802,-122.471355)
(37.712804,-122.471163)

********************************************************************************
 Input Data
********************************************************************************

The input data is to be formatted as follows
[latitude] [longitude] [streetname]
It must be tab delimited as well as have a newline at the end of the file. If a
certain line does not follow this format, it will be skipped.

********************************************************************************
 Output
********************************************************************************

If the geocode does not exist, the function will return a friendly error saying 
that a geocode was not found. Else it will return the correct geocode(s) of the 
intersection of the two roads. 

 *** if there is no intersection ***

Enter a command (type help for a list of commands):
geocode
Enter the first street name
1
Enter the second street name
front
Geocode not found. There is no intersection between these roads.

********************************************************************************
 How it works
********************************************************************************

By taking the list of data, we need a data structure that will easily represent 
the data and solve this problem. Because we need to optimize for speed in
returning a geocode, our final data structure will be a hashtable where the pair
of streetnames will be the key and the list of latitude/longitude pair will be the
value.

To build our end result, we will first take the data and condense it into a
hashtable. We will then "sort" the hashtable by value, by writing a comparator
that will first sort by longitude, then latitude, giving us an array. Afterwards,
we will continually splice the array in chunks of the same latitude/longitude. 
For each splice, we will get all the possible pairs of roads and insert it into
the final hashtable. Our final hashtable will look like the following:
 
[street1]_[street2] => [(latitude, longitude), (latitude, longitude), ...]

Street1 will always come before street2 alphabetically


 logs.txt - (not necessarily there) the log file from the logger
 
 unreadable.txt - an unreadable file so I could test readability in my unit test

 sf_street_data.txt - the file with lat/long pairs provided. It also has a couple of
                      extra points that I added to make sure I was checking for errors
                      in reading the input data
