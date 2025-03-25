# frozen_string_literal: true

require_relative "../lib/builtin_commands"
require_relative "../lib/shell_status"
require_relative "../lib/utils"

trap ("SIGINT") do
  $stdout.write("\n")
  Utils.show_prompt
end

def main
  loop do
    Utils.show_prompt

    # Wait for user input
    begin
      command, *args = gets.chomp.split(" ")
    rescue NoMethodError
      $stdout.write("exit\n") if $stdin.tty?
      BuiltinCommands.exit_shell($last_exit_code)
    end

    next if command.nil?

    Utils.handle_command(command, *args)
  end
end

main if __FILE__ == $PROGRAM_NAME
