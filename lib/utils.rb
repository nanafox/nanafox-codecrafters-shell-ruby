require "pathname"

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
      when "type"
        BuiltinCommands.type(*args)
      when "pwd"
        BuiltinCommands.pwd
      when "cd"
        BuiltinCommands.chdir(args[0])
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

    def handle_command_not_found(command, error: nil)
      $stderr.write("#{command}: #{error || "command not found"}\n")
      $last_exit_code = ShellStatus::COMMAND_NOT_FOUND
    end

    def system_path
      @path ||= ENV["PATH"].split(":")
    end

    def find_command_path(command)
      system_path.each do |path|
        command_path = Pathname.new("#{path}/#{command}")
        return command_path.to_s if command_path.exist? && command_path.executable?
      end

      nil
    end

    # Determines whether a command is available in the user's PATH environment.
    #
    # @param command [String] The command to check.
    #
    # @return [Boolean] `true` if it's a PATH command, `false` otherwise.
    def path_command?(command)
      !find_command_path(command).nil?
    end

    # Handle commands found in the user's PATH.
    #
    # @param command [String] The command to execute.
    # @param args [Array] An array of command arguments.
    def handle_path_command(command, *args)
      system("#{command} #{args.join(" ")}")
      $last_exit_code = $?.exitstatus
    end
  end
end
