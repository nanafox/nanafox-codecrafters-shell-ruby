while true
  $stdout.write("$ ")

  # Wait for user input
  command, *_ = gets.chomp.split(" ")
  $stderr.write("invalid_command: #{command} not found\n") unless command.nil?
end

