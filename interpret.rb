if __FILE__ == $0
  puts "Oops, did you mean to run HiveStart.rb instead?"
  exit
end

def HIVE_interpret(cmd, isLocal, interactive, lVarStore, hVarStore)
      if cmd.start_with?("var")
        lVarStore[cmd.split(' ')[1]] = cmd.split(' ')[2]
      elsif cmd.start_with?("hivevar")
        hVarStore[cmd.split(' ')[1]] = cmd.split(' ')[2]
      elsif cmd.start_with?("is")
        if(cmd.split(' ')[1].start_with?("var_") and cmd.split(' ')[2].start_with?("var_"))
          lVarStore[cmd.split(' ')[1]] = lVarStore[cmd.split(' ')[2]]
        elsif(cmd.split(' ')[1].start_with?("hvar_") and cmd.split(' ')[2].start_with?("var_"))
          hVarStore[cmd.split(' ')[1]] = lVarStore[cmd.split(' ')[2]]
        elsif(cmd.split(' ')[1].start_with?("var_") and cmd.split(' ')[2].start_with?("hvar_"))
          lVarStore[cmd.split(' ')[1]] = hVarStore[cmd.split(' ')[2]]
        else
          hVarStore[cmd.split(' ')[1]] = hVarStore[cmd.split(' ')[2]]
        end
      elsif cmd.start_with?("%")
        #Do nothing, this is a comment
      else
        cmd2 = cmd.split(' ')
        indexi = 0
        while indexi < cmd2.length
          if cmd2[indexi].start_with?("var_")
            cmd2[indexi] = lVarStore[cmd2[indexi]]
          elsif cmd2[indexi].start_with?("hvar_")
            cmd2[indexi] = hVarStore[cmd2[indexi]]
          end
          indexi = indexi + 1
        end
        cmd = " "
        indexi = 0
        while indexi < cmd2.count
          #HIVE_print(indexi.to_s)
          #cmd = cmd + cmd2[indexi] + " "
          cmd = "#{ cmd } #{ cmd2[indexi] }"
          indexi = indexi + 1
        end
      end
      cmd = cmd.strip
  if cmd.start_with?("print")
    if isLocal
      cmd.slice! "print"
      HIVE_print(cmd)
    end
  elsif cmd.start_with?("var")
    #varStore[cmd.split(' ')[1]] = cmd.split(' ')[2]
  elsif cmd.split(' ')[0] == "sys"
    if cmd.split(' ')[1] == "sudo"
      HIVE_print("Use of sudo is not allowed")
    elsif cmd.split(' ')[1] == "su"
      HIVE_print("Logging in as root is not allowed")
    else
      cmd['sys '] = ''
      require 'rbconfig'
      include RbConfig
      case CONFIG['host_os']
        when /mswin|windows/i
          # Windows
          HIVE_print("The SYS command is not yet supported on your platform.")
        when /linux|arch/i
          # Linux
          system(cmd)
        when /sunos|solaris/i
          # Solaris
          HIVE_print("The SYS command is not yet supported on your platform.")
        when /darwin/i
          #MAC OS X
          HIVE_print("The SYS command is not yet supported on your platform.")
        else
          # whatever
          HIVE_print("The SYS command is not yet supported on your platform.")
      end
    end
  elsif cmd.split(' ')[0] == "sysc"
    if cmd.split(' ')[1] == "shutdown"
      require 'rbconfig'
      include RbConfig
      case CONFIG['host_os']
        when /mswin|windows/i
          # Windows
          system("shutdown -s -f -t 10")
        when /linux|arch/i
          # Linux
          system("sudo halt")
        when /sunos|solaris/i
          # Solaris
          HIVE_print("The SYSc command is not yet supported on your platform.")
        when /darwin/i
          #MAC OS X
          HIVE_print("The SYSc command is not yet supported on your platform.")
        else
          # whatever
          HIVE_print("The SYSc command is not yet supported on your platform.")
      end
    elsif cmd.split(' ')[1] == "install"
      require 'rbconfig'
      include RbConfig
      case CONFIG['host_os']
        when /mswin|windows/i
          # Windows
          HIVE_print("The SYSc command is not yet supported on your platform.")
        when /linux|arch/i
          # Linux
          HIVE_print(system("sudo apt-get install " + cmd.split(' ')[2]))
        when /sunos|solaris/i
          # Solaris
          HIVE_print("The SYSc command is not yet supported on your platform.")
        when /darwin/i
          #MAC OS X
          HIVE_print("The SYSc command is not yet supported on your platform.")
        else
          # whatever
          HIVE_print("The SYSc command is not yet supported on your platform.")
      end
    end
  elsif cmd.start_with?("#")
    #This is a directive
    dcmd = cmd.split(' ')[0]
    dcmd2 = cmd.split(' ')[1]
    dcmd.slice!("#")
    if dcmd == "HIVE"
      #For now, just print version
      dcmd.slice!('HIVE:')
      if dcmd2.split('.')[3].to_i > lVarStore["var_hiveenv_version"].split('.')[3].to_i
        HIVE_print("Insufficient version. You have version #{ lVarStore["var_hiveenv_version"] }, this program requires #{ dcmd2 }")
        require './hivelib/warning'
        declare_warning("DIRECTIVE:VERSION:INSUFFICIENTVERSION", isLocal)
        #terminate the program
      else
        HIVE_print("This program requires HIVE v" + cmd.split(' ')[1].to_s)
        HIVE_print("You have HIVE v" + lVarStore["var_hiveenv_version"].to_s)
      end
    else
      HIVE_print("ERROR: bad directive")
    end
  elsif cmd.split(' ')[0].split('>')[0] == "math"
    if cmd.split(' ')[0].split('>')[1] == "add"
      require "./hivelib/math.rb"
      result = add(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
      if isLocal
        HIVE_print(result)
      else
        return result
      end
    elsif cmd.split(' ')[0].split('>')[1] == "sub"
      require "./hivelib/math.rb"
      result = subtract(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
      if isLocal
        HIVE_print(result)
      else
        return result
      end
    elsif cmd.split(' ')[0].split('>')[1] == "mul"
      require "./hivelib/math.rb"
      result = multiply(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
      if isLocal
        HIVE_print(result)
      else
        return result
      end
    elsif cmd.split(' ')[0].split('>')[1] == "div"
      require "./hivelib/math.rb"
      result = divide(cmd.split(' ')[1].to_i, cmd.split(' ')[2].to_i)
      if isLocal
        HIVE_print(result)
      else
        return result
      end
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
