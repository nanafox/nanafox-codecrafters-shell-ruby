module Utils
  class << self
    # Handles builtin commands.
    #
    # @param command [String] The command to execute
    # @param args [Array] Any other arguments that comes with the command.
    def handle_builtin_command(command, *args)
      case command
      when "exit"
        status = args[0]&.to_i || $last_exit_code
        BuiltinCommands.exit_shell(status)
      when "echo"
        BuiltinCommands.echo(args.join(" "))
      end
    end

    # Determines whether a command is a builtin command or not.
    #
    # @param command [String] The command to check.
    #
    # @return [Boolean] `true` if the command is a builtin command, `false`
    #   otherwise
    def builtin_command?(command)
      BuiltinCommands::CMD_LIST.include? command
    end

    def handle_command_not_found(command)
      $stderr.write("#{command}: command not found\n")
      $last_exit_code = ShellStatus::COMMAND_NOT_FOUND
    end
  end
end
