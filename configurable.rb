require 'yaml'

module MediaLair
  module Configurable
    def configure(opts = {})
      opts.each {|key,value| config[key.to_sym] = value}
    end

    def configure_from_yaml_file(file)
      configure(YAML.load_file(file))
    end

    def config
      @config ||= {}
    end
  end
end