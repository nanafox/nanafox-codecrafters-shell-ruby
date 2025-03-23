# frozen_string_literal: true

module ShellStatus
  COMMAND_NOT_FOUND = 127
  SUCCESS = 0
  FAILURE = 1

  $last_exit_code = SUCCESS
end
