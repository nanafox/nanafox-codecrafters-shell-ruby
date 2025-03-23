# frozen_string_literal: true

require_relative "../lib/builtin_commands"
require_relative "../lib/shell_status"
require_relative "../lib/utils"

$last_exit_code = ShellStatus::SUCCESS  # tracks the status code of execute commands

def main
  while true
    $stdout.write("$ ")

    # Wait for user input
    command, *args = gets.chomp.split(" ")

    if Utils.builtin_command? command
      Utils.handle_builtin_command(command, *args)
    else
      $stderr.write("#{command}: command not found\n") unless command.nil?
      $last_exit_code = ShellStatus::COMMAND_NOT_FOUND
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
