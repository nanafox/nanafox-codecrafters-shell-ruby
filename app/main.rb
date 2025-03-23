while true
  $stdout.write("$ ")

  # Wait for user input
  command, *_ = gets.chomp.split(" ")
  $stderr.write("#{command}: command not found\n") unless command.nil?
end

