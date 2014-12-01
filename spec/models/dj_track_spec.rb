require 'spec_helper.rb'

describe DjTrack do

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
      it { expect(@dj_track.image_url).to eq("https://www.bbc.co.uk/music/images/artists/542x305/123-abc-456-def-789-ghi.jpg") }
    end

  end


  describe "the artist URL" do

    describe "where there is no artist mbid" do
      before { @dj_track.artist_mbid = "" }
      it { expect(@dj_track.artist_url).to eq("/music/artists?q=test%20artist") }
    end
    
    describe "where there is an artist mbid" do
      it { expect(@dj_track.artist_url).to eq("/music/artists/123-abc-456-def-789-ghi") }
    end

  end


end