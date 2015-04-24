if __FILE__ == $0
  puts "Oops, did you mean to run HiveStart.rb instead?"
  exit
end

def HIVE_interpret(cmd, isLocal, interactive, varStore)
  if cmd.start_with?("print")
    if isLocal
      cmd.slice! "print"
      cmd2 = cmd.split(' ')
      indexi = 0
      while indexi < cmd2.length
        if cmd2[indexi].start_with?("var_")
          cmd2[indexi] = varStore[cmd2[indexi]]
        end
        indexi = indexi + 1
      end
      cmd = ""
      indexi = 0
      while indexi < cmd2.length
        cmd = cmd2[indexi] + " "
        indexi = indexi + 1
      end
      HIVE_print(cmd)
    end
  elsif cmd.start_with?("#")
    #This is a directive
    dcmd = cmd.split(' ')[0]
    dcmd.slice!("#")
    if dcmd == "HIVE"
      #For now, just print version
      HIVE_print("This program requires HIVE v" + cmd.split(' ')[1].to_s)
    else
      HIVE_print("ERROR: bad directive")
    end
  elsif cmd.start_with?("add")
    require "./hivelib/math.rb"
    result = add(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
    if isLocal
      HIVE_print(result)
    else
      return result
    end
  elsif cmd.start_with?("subtract")
    require "./hivelib/math.rb"
    result = subtract(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
    if isLocal
      HIVE_print(result)
    else
      return result
    end
  elsif cmd.start_with?("multiply")
    require "./hivelib/math.rb"
    result = multiply(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
    if isLocal
      HIVE_print(result)
    else
      return result
    end
  elsif cmd.start_with?("divide")
    require "./hivelib/math.rb"
    result = divide(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
    if isLocal
      HIVE_print(result)
    else
      return result
    end
  elsif cmd.start_with?("pause")
    HIVE_print("Pausing")
    if cmd.split(' ')[1].to_i == nil
      sleep(1)
    else
      sleep(cmd.split(' ')[1].to_i)
    end
    return nil
  else
    return "PARSEERROR"
  end
end

def HIVE_print(line)
  a = line.to_s.strip
  puts "[HIVEPARSE]: " + a
end
