require 'grape'
require_relative 'lib/tv'
require_relative 'configurable'

class API < Grape::API
  extend MediaLair::Configurable

  VIDEO_FILE_FORMATS = %w(avi mpg mpeg mkv divx mp4 mov wmv)

  valid_configuration_keys :tv_directory
  configure_from_yaml_file 'configuration.yml'

  format :json

  helpers do
  end

  resources :media do
    get :latest_tv_episodes do
      tv = MediaLair::Tv.new(API.config[:tv_directory])
      tv.latest_tv_episodes
    end
  end
end