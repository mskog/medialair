require 'spec_helper'

describe "MediaLair::Tv" do
  let(:directory){File.absolute_path('spec/fixtures/tv/latest_tv_episodes/tv')}
  subject{MediaLair::Tv.new(directory)}

  describe '.latest_tv_episodes' do
    it "contains the name of the shows" do
      shows = ['Breaking Bad']
      results = subject.latest_tv_episodes
      results.map {|show| show[:name]}.should eq shows
    end

    it "contains the name of the newest episode for the shows" do
      time = Time.now
      File.stub(:ctime).with(/Breaking.Bad.S01E04/).and_return(time-1)
      File.stub(:ctime).with(/Breaking.Bad.S02E04/).and_return(time)
      File.stub(:ctime).with(/Breaking.Bad.S02E06/).and_return(time+1)
      expected_results = [
        {:name => 'Breaking Bad', :filename => 'Breaking.Bad.S02E06.mkv', :created_at => time+1},
      ]
      results = subject.latest_tv_episodes
      results.should eq expected_results
    end
  end
end