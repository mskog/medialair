require 'grape'

class API < Grape::API
  VIDEO_FILE_FORMATS = %w(avi mpg mpeg mkv divx mp4 mov wmv)
  TV_DIRECTORY = "/stuff/media/tv"

  format :json

  helpers do
    def latest_tv_episodes(directory)
      Dir.glob("#{directory}/*").map do |tv_show|
        latest_episode = latest_episode_for_show(tv_show)
        next if latest_episode.nil?
        {:tvshow => File.basename(tv_show)}.merge latest_episode_for_show(tv_show)
      end.compact
    end

    def latest_episode_for_show(directory)
      newest_file Dir.glob("#{directory}/**/*.{#{VIDEO_FILE_FORMATS.join(',')}}")
    end

    def newest_file(files)
      return nil if files.empty?
      file = files.sort_by{|file| File.ctime(file)}.reverse.first
      {:filename => File.basename(file), :created_at => File.ctime(file)}
    end
  end

  resources :media do
    get :latest_tv_episodes do
      latest_tv_episodes(TV_DIRECTORY)
    end
  end
end