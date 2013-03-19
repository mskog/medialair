module MediaLair
  class Music
    VIDEO_FILE_FORMATS = %w(avi mpg mpeg mkv divx mp4 mov wmv)

    def initialize(new_music_directory)
      @new_music_directory = new_music_directory
    end

    def new_music
      Dir.entries(@new_music_directory).map do |entry|
        next if entry == '.' || entry == '..'
        File.basename(entry) if File.directory?(File.join(@new_music_directory,entry))
      end.compact
    end
  end
end