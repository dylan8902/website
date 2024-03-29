require 'spec_helper.rb'

RSpec.describe DjTrack do

  before do
    @dj_track = DjTrack.new(
      artist_mbid: "123-abc-456-def-789-ghi",
      artist: "test artist"
    )
  end


  describe "the artist image URL" do

    describe "where there is no artist mbid" do
      before { @dj_track.artist_mbid = "" }
      it { expect(@dj_track.image_url).to eq("/images/no_mbzid_544x306.png") }
    end

    describe "where there is an artist mbid" do
      it { expect(@dj_track.image_url).to eq("/images/no_mbzid_544x306.png") }
    end

  end


  describe "the artist URL" do

    describe "where there is no artist mbid" do
      before { @dj_track.artist_mbid = "" }
      it { expect(@dj_track.artist_url).to eq("/music/artists?q=test+artist") }
    end

    describe "where there is an artist mbid" do
      it { expect(@dj_track.artist_url).to eq("/music/artists/123-abc-456-def-789-ghi") }
    end

  end


end