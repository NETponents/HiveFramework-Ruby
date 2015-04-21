if __FILE__ = $0
  exit
end

def HIVE_interpret(cmd, isLocal)
  if cmd.start_with?("print")
    if isLocal
      puts cmd.slice! "print"
    end
  else
    return "PARSEERROR"
  end
end
