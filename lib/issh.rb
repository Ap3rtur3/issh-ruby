# Issh.rb
#
# Entry point for application

require_relative 'interface'
require_relative 'action_parser'
require_relative 'utility'
require 'inquirer'

module Issh
  class Main
    def initialize
      check_datafile

      @interface = Interface2.new
      @parser = ActionParser.new(DATAFILE_PATH)
      
      puts GREETING
    end

    def run
      continue_loop = true

      while continue_loop
        action = @interface.interact
        continue_loop = @parser.parse(action)
        @interface.reset_index!
      end
    end

    # Checks if datafile exists
    # Creates one if not
    def check_datafile
      unless File.exist?(DATAFILE_PATH)
        File.open(DATAFILE_PATH, 'w') do |f|
          f.write(DATAFILE_SAMPLE)
        end
      end
    end
  end

  issh = Main.new
  issh.run

  puts 'Bye'
end
