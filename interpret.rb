if __FILE__ == $0
  exit
end

def HIVE_interpret(cmd, isLocal)
  if cmd.start_with?("print")
    if isLocal
      cmd.slice! "print"
      HIVE_print(cmd)
    end
  else
    return "PARSEERROR"
  end
end

def HIVE_print(line)
  a = line.strip
  puts "[HIVEPARSE]: " + a
end
