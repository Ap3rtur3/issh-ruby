require 'json'

module Issh
  DATAFILE_PATH = './issh.json'
  DATAFILE_SAMPLE_RAW = {
      endpoints: []
  }
  DATAFILE_SAMPLE = JSON.pretty_unparse(DATAFILE_SAMPLE_RAW)
  SSH_ARG_MAP = {
      port: '-p',
      user: '-l',
      identity: '-i',
      host: '',
  }
  GREETING = ' === Interactive ssh === '

  module FileData
    # Returns contents of data file as symbolized hash
    def file_data
      fd = JSON.parse(File.read(DATAFILE_PATH))
      check_file_data(fd)
      symbolize_keys(fd)
    end

    # Saves data as json to file
    # Returns if operations were successful
    def save_data(data)
      if data.is_a? Hash
        File.open(@file, 'w+') do |f|
          f.write(JSON.pretty_unparse(data))
        end

        # TODO: Check if save was successful?
        true
      else
        false
      end
    end

    def check_file_data(file_data)
      #sample_keys = DATAFILE_SAMPLE_RAW.keys
      #missing_keys = sample_keys - file_data.keys.map(:to_sym)
      #
      #if missing_keys.length > 0
      #  puts 'Datafile possibly corrupted, following keys are missing: ' <<
      #           missing_keys.map(:to_s).join(' ')
      #end
    end

    # Returns object with recursively symbolized keys
    # Only cares about hashes or arrays of hashes
    def symbolize_keys(obj)
      if obj.is_a? Hash
        symbolize_hash_keys(obj)
      elsif obj.is_a? Array
        obj.map{ |item| symbolize_keys(item) }
      else
        obj
      end
    end

    # Converts hash keys to symbols and returns hash
    def symbolize_hash_keys(hash)
      Hash[hash.map{ |(k, v)| [k.to_sym, symbolize_keys(v)] }]
    end
  end
end