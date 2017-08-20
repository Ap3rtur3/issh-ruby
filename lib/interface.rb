

require_relative 'utility'
require 'json'

module Issh
  class Interface2
    include FileData

    # Item array position definitions
    ITEM_KEY      = 0
    ITEM_DATA     = 1
    ITEM_DEFAULT  = 2

    # Exceptions
    class MethodNotFoundException < Exception; end

    def initialize
      @routes = {
          index: {
              header: 'Choose your action',
              items: [
                  [:start_ssh, 'Start ssh session'],
                  [:add_endpoint, 'Add ssh endpoint'],
                  [:remove_endpoint, 'Remove ssh endpoint'],
                  [:exit, 'Exit'],
              ]
          },
          start_ssh: {
              header: 'Choose an endpoint',
              items: [],
          },
          add_endpoint: {
              header: 'Add new ssh endpoint',
              items: [
                  [:name, 'Endpoint name'],
                  [:host, 'Host'],
                  [:port, 'Port', 22],
                  [:user, 'User'],
                  [:identity, 'Identity file path', '~/.ssh/id_rsa']
              ],
          },
          remove_endpoint: {
              header: 'Remove ssh endpoint',
              items: []
          }
      }

      reset_index!
    end

    def interact
      loop do
        method_name = :"interact_#{@current}"

        if respond_to? method_name, :include_private
          result = send(method_name)

          if result[:type] == :route
            @current = result[:name]
            redo
          elsif result[:type] == :action
            return result
          end
        else
          raise MethodNotFoundException, "Method: #{method_name}"
        end
      end
    end

    def reset_index!
      @current = :index
    end


    private

    def interact_index
      route = @routes[@current]
      pos = Ask.list route[:header],
                     route[:items].map{ |item| item[ITEM_DATA] },
                     {response: false}
      item = route[:items][pos]

      if item[ITEM_KEY] == :exit
        action(:exit)
      else
        route(item[ITEM_KEY], item)
      end
    end

    def interact_start_ssh
      route = @routes[@current]
      items = endpoint_list << {name: 'Return'}
      pos = Ask.list route[:header],
                     items.map { |endpoint| endpoint[:name]},
                     {response: false}
      item = items[pos]

      if item[:name] == 'Return'
        route(:index)
      else
        action(:start_ssh, item)
      end
    end

    def interact_add_endpoint
      route = @routes[@current]

      data = route[:items].map do |item|
        if item[ITEM_DEFAULT]
          answer = Ask.input item[ITEM_DATA], default: item[ITEM_DEFAULT], response: false
        else
          answer = Ask.input item[ITEM_DATA], response: false
        end

        [item[ITEM_KEY], answer]
      end.to_h

      # TODO: Validate!!!

      puts "Added #{data[:user]}@#{data[:host]}:#{data[:port]} as #{data[:name]}"

      action(:add_endpoint, data)
    end

    def interact_remove_endpoint
      route = @routes[@current]
      items = endpoint_list << {name: 'Return'}
      pos = Ask.list route[:header],
                     items.map { |endpoint| endpoint[:name]},
                     {response: false}
      item = items[pos]
  
      if item[:name] == 'Return'
        route(:index)
      else
        action(:remove_endpoint, item)
      end
    end

    def route(name, data = nil)
      {
          type: :route,
          name: name,
          data: data
      }
    end

    def action(name, data = nil)
      {
          type: :action,
          name: name,
          data: data
      }
    end

    # Returns endpoints which are formatted based on action
    def endpoint_list
      parsed_data = file_data
      endpoints = parsed_data[:endpoints]

      (endpoints && endpoints.is_a?(Array)) ? endpoints : []
    end
  end
end