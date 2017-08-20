# Action Parser
#
# Executes given actions as console commands

require_relative 'utility'

module Issh
  class ActionParser
    include FileData

    # Exceptions
    class ActionNotFoundException < Exception; end

    def initialize(filepath)
      @file = filepath
    end

    # Parses payload and returns whether application should continue or not
    def parse(payload)
      parse_action(payload)
    end


    private

    def parse_action(payload)
      method_name = "action_#{payload[:name]}"

      if respond_to? method_name, :include_private
        send(method_name, payload)
      else
        raise ActionNotFoundException, payload.inspect
      end
    end

    def action_exit(_)
      false
    end

    def action_start_ssh(payload)
      mapped_args = payload[:data].map do |key, val|
        param = SSH_ARG_MAP[key]
        if param && val.respond_to?(:length) && val.length > 0
          "#{param} #{val}"
        else
          ''
        end
      end
      
      ssh_args = mapped_args.join(' ')
      ssh_cmd = "ssh #{ssh_args}"
      puts ssh_cmd
      system(ssh_cmd)

      false
    end

    def action_add_endpoint(payload)
      fd = file_data
      fd[:endpoints] << payload[:data]
      save_data(fd)
    end

    def action_remove_endpoint(payload)
      fd = file_data
      fd[:endpoints] -= [payload[:data]]
      save_data(fd)
    end
  end
end