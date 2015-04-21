#!/usr/bin/ruby

puts "HIVE Framework copyright 2015 Joshua Zenn"
puts "This program is distributed under the MIT license"
puts "Commercial use with this copy of this program is prohibited"
puts "Starting up..."
if File.exist?('settings.txt') != true
  setup()
end
puts "Getting dependencies"
require "interpret.rb"
puts "Creating varstore"
#Create varstore
puts "Starting portstore"
#Create portstore
puts "Starting networking"
Thread.start(directorNet(20000, 200001))
puts "Ready"
loop do
  puts "int: "
  command = gets.strip
  if command = "exit"
    exit
  else if command == "run"
    #Run the specified file
  else if command == "help"
    #Open help files
  else
    print HIVE_interpret(command, true)
  end
end

def directorNet(port, startPort)
  require "socket"  
  dts = TCPServer.new('localhost', port)
  nextport = startPort
  loop do  
    Thread.start(dts.accept) do |s|  
      puts(s, " has connected")
      s.write(nextport)
      puts(s, " has been redirected to ", nextport)  
      s.close
      nextport = nextport + 1
    end  
  end  
end

def setup()
  print "Enter a unique hostname for this node: "
  setup_hostname = gets.strip
  puts "License"
  puts "========"
  puts "By using this program, you agree to the terms listed in LICENSE in the program directory. Since this is the free version, you also agree that this copy of the program MAY NOT be used for commercial or for-profit purposes."
  print "Accept terms? [y/n]: "
  license = gets.strip
  if license != "y" and license != "Y"
    puts "Did not accept license, terminating program"
    exit
    #terminate program
  end
  puts "Finished setup, restarting startup sequence..."
end
