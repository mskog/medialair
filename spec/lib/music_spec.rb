require 'spec_helper'

describe "MediaLair::Music" do
  
  subject{MediaLair::Music.new(directory)}
  describe '.new_music' do
    context "when the directory has albums in it" do
      let(:directory){File.absolute_path('spec/fixtures/music/new_music/albums')}

      it "returns an array of the folder names in the New Music Directory" do
        subject.new_music.should eq ['abba - best of', 'bruce springsteen - born to run']
      end
    end

    context "when the directory has no albums in it" do
      let(:directory){File.absolute_path('spec/fixtures/music/new_music/empty_albums')}

      it "returns an empty array" do
        subject.new_music.should be_empty
      end
    end
  end
end