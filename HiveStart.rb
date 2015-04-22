#!/usr/bin/ruby

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

puts "HIVE Framework copyright 2015 Joshua Zenn"
puts "This program is distributed under the MIT license"
puts "Commercial use with this copy of this program is prohibited"
puts "Parsing parameters"
settings_silent = false
settings_startscript = ""
ARGV.each do|a|
  if a == "-silent" or a == "-s"
    settings_silent = true
  elsif a.start_with?("-script:")
    a.slice!("-script:")
    settings_startscript = a
  end
end
puts "Starting up..."
if File.exist?('settings.txt') != true
  if settings_silent
    puts "Silent mode is on, using default parameters"
    setup_hostname = "H1N001"
  else
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
    end
  end
    puts "Finished setup, restarting startup sequence..."
end
puts "Getting dependencies"
require "./interpret.rb"
puts "Creating varstore"
#Create varstore
puts "Starting portstore"
#Create portstore
puts "Starting networking"
Thread.start{directorNet(20000, 200001)}
puts "Ready"
if settings_silent
  puts "Silent mode is enabled, running specified script file."
  if settings_startscript == ""
    puts "Script parameter is empty, exiting."
    exit
  else
    File.open("my/file/path", "r") do |f|
      f.each_line do |line|
        puts HIVE_interpret(command, true)
      end
    end
  end
end
loop do
  print "[HIVE]: "
  command = gets.strip
  if command == "exit"
   exit
  elsif command == "run"
   #Run the specified file
  elsif command == "help"
    #Open help files
  else
    puts HIVE_interpret(command, true)
  end
end

exit
