require 'yaml'

module MediaLair
  module Configurable
    def configure(opts = {})
      opts.each {|key,value| config[key.to_sym] = value if @valid_config_keys.include? key.to_sym}
    end

    def configure_from_yaml_file(file)
      configure(YAML.load_file(file))
    end

    def config
      @config ||= {}
    end

  private

    def valid_configuration_keys(*keys)
      @valid_config_keys = keys
    end
  end
end