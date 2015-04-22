if __FILE__ == $0
  exit
end

def HIVE_interpret(cmd, isLocal)
  if cmd.start_with?("print")
    if isLocal
      cmd.slice! "print"
      HIVE_print(cmd)
    end
  elsif cmd.start_with?("add")
    require "./hivelib/math.rb"
    result = add(cmd.split(' ')[1], cmd.split(' ')[2])
    return result
  elsif cmd.start_with?("subtract")
    require "./hivelib/math.rb"
    result = subtract(cmd.split(' ')[1], cmd.split(' ')[2])
    return result
  elsif cmd.start_with?("multiply")
    require "./hivelib/math.rb"
    result = multiply(cmd.split(' ')[1], cmd.split(' ')[2])
    return result
  elsif cmd.start_with?("divide")
    require "./hivelib/math.rb"
    result = divide(cmd.split(' ')[1], cmd.split(' ')[2])
    return result
  else
    return "PARSEERROR"
  end
end

def HIVE_print(line)
  a = line.strip
  puts "[HIVEPARSE]: " + a
end
