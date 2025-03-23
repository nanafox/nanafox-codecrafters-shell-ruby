module BuiltinCommands
  CMD_LIST = %w[exit]

  class << self
    # Exits the shell program with the provided `status_code` or whatever the last
    # exit code was if the specific one is not provided
    #
    # @param status_code [Integer] The status code to use when exiting the shell.
    #   Defaults to the last exit status code.
    def exit_shell(status_code = $last_exit_code)
      exit status_code
    end
  end
end
