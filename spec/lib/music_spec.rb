require 'spec_helper'

describe "MediaLair::Music" do
  let(:directory){File.absolute_path('spec/fixtures/music/new_music/')}
  subject{MediaLair::Music.new(directory)}

  describe '.new_music' do
    it "returns an array of the folder names in the New Music Directory" do
      subject.new_music.should eq ['abba - best of', 'bruce springsteen - born to run']
    end
  end
end