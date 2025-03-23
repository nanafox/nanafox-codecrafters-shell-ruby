module BuiltinCommands
  CMD_LIST = %w[exit echo type pwd]

  class << self
    # Exits the shell program with the provided `status_code` or whatever the last
    # exit code was if the specific one is not provided
    #
    # @param status_code [Integer] The status code to use when exiting the shell.
    #   Defaults to the last exit status code.
    def exit_shell(status_code = $last_exit_code)
      exit status_code
    end

    def echo(string)
      $stdout.write("#{string}\n")
      $last_exit_code = ShellStatus::SUCCESS
    end

    # Prints the type of command received on the command line.
    #
    # @param commands [Array] An array of commands to check types for
    def type(*commands)
      if commands.empty?
        $last_exit_code = ShellStatus::SUCCESS
        return
      end

      commands.each do |command|
        if Utils.builtin_command? command
          $stdout.write("#{command} is a shell builtin\n")
          $last_exit_code = ShellStatus::SUCCESS
        elsif Utils.path_command? command
          $stdout.write("#{command} is #{Utils.find_command_path(command)}\n")
          $last_exit_code = ShellStatus::SUCCESS
        else
          Utils.handle_command_not_found(command, error: "not found")
        end
      end
    end

    # Prints the current working directory
    def pwd
      $stdout.write("#{Dir.pwd}\n")
      $last_exit_code = ShellStatus::SUCCESS
    end
  end
end
