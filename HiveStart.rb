#!/usr/bin/ruby

puts "HIVE Framework copyright 2015 Joshua Zenn"
puts "This program is distributed under the MIT license"
puts "Commercial use with this copy of this program is prohibited"
puts "Starting up..."
if File.exist?('settings.txt') != true
  setup()
end

def setup()
  print "Enter a unique hostname for this node: "
  setup_hostname = gets.strip
  puts "License"
  puts "========"
  puts "By using this program, you agree to the terms listed in LICENSE in the program directory. Since this is the free version, you also agree that this copy of the program MAY NOT be used for commercial or for-profit purposes."
  print "Accept terms? [y/n]: "
  license = gets.strip
  if license != "y" or "Y"
    puts "Did not accept license, terminating program"
    #terminate program
  end
end
