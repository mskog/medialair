module MediaLair
  class Tv
    VIDEO_FILE_FORMATS = %w(avi mpg mpeg mkv divx mp4 mov wmv)

    def initialize(tv_directory)
      @tv_directory = tv_directory
    end

    def latest_tv_episodes
      Dir.glob("#{@tv_directory}/*").map do |tv_show|
        latest_episode = latest_episode_for_show(tv_show)
        next unless latest_episode
        {:name => File.basename(tv_show)}.merge latest_episode
      end.compact
    end

  private

    def latest_episode_for_show(directory)
      self.class.newest_file Dir.glob("#{directory}/**/*.{#{VIDEO_FILE_FORMATS.join(',')}}")
    end

    def self.newest_file(files)
      return nil if files.empty?
      file = files.sort_by{|file| File.ctime(file)}.reverse.first
      {:filename => File.basename(file), :created_at => File.ctime(file)}
    end
  end
end