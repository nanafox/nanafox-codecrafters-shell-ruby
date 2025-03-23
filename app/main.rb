# frozen_string_literal: true

require_relative "../lib/builtin_commands"
require_relative "../lib/shell_status"
require_relative "../lib/utils"

$last_exit_code = ShellStatus::SUCCESS  # tracks the status code of execute commands

def main
  while true
    $stdout.write("$ ")

    # Wait for user input
    begin
      command, *args = gets.chomp.split(" ")
    rescue NoMethodError, Interrupt
      $stdout.write("exit\n")
      Utils.handle_builtin_command("exit", $last_exit_code)
    end

    next if command.nil?

    if Utils.builtin_command? command
      Utils.handle_builtin_command(command, *args)
    elsif Utils.path_command? command
      Utils.handle_path_command(command, *args)
    else
      Utils.handle_command_not_found(command)
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
