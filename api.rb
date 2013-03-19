require 'grape'
require_relative 'lib/tv'
require_relative 'lib/music'
require_relative 'configurable'

class API < Grape::API
  extend MediaLair::Configurable
  
  configure_from_yaml_file 'configuration.yml'

  format :json

  helpers do
  end

  resources :media do
    get :latest_tv_episodes do
      tv = MediaLair::Tv.new(API.config[:tv_directory])
      tv.latest_tv_episodes.sort_by{|episode| episode['created_at']}.reverse
    end

    get :new_music do
      music = MediaLair::Music.new(API.config[:new_music_directory])
      music.new_music
    end
  end
end