require 'rails_helper.rb'

RSpec.describe ApplicationHelper do

  describe "full title" do

    it "has the just my name when no extra title" do
      expect(full_title("")).to eq("Dylan Jones")
    end

    it "has some colons in the title with some text" do
      expect(full_title("Test")).to eq("Dylan Jones:: Test")
    end

  end


  describe "timestamp" do

    it "has some interesting text for a zero time" do
      expect(timestamp(0, "Unknown")).to eq("Unknown")
    end

    it "says a minute ago for 60 seconds ago" do
      seconds = Time.now.to_i - 60
      time = Time.at(seconds)
      expected = "<time class=\"ago\" title=\"#{time}\" datetime=\"#{time.xmlschema}\" data-timestamp=\"#{seconds}\">1 minute ago</time>".html_safe
      expect(timestamp(seconds, "Unknown")).to eq(expected)
    end

    it "says a minute from now for 60 seconds" do
      seconds = Time.now.to_i + 60
      time = Time.at(seconds)
      expected = "<time class=\"ago\" title=\"#{time}\" datetime=\"#{time.xmlschema}\" data-timestamp=\"#{seconds}\">1 minute from now</time>".html_safe
      expect(timestamp(seconds, "Unknown")).to eq(expected)
    end

  end


  describe "linkify" do

    it "converts image URL to image" do
      link = "http://test.com/image.jpg"
      expect(linkify(link)).to eq("<img src=\"#{link}\">".html_safe)
    end

    it "converts a URL to a link" do
      link = "http://test.com/"
      expect(linkify(link)).to eq("<a href=\"#{link}\" target=\"_blank\">#{link}</a>".html_safe)
    end

  end


  describe "icon" do

    it "prints the icon markup" do
      expect(icon("test")).to eq("<i class=\"far fa-test\"></i>".html_safe)
    end

  end


  describe "distance_sql" do

    it "is the SQL calculatation for distance" do
      sql = "7912*ASIN(SQRT(POWER(SIN((lat-1.0)*pi()/180/2),2)+COS(lat*pi()/180)*COS(1.0*pi()/180)*POWER(SIN((lng-1.0)*pi()/180/2),2)))"
      expect(distance_sql(1.0, 1.0)).to eq(sql)
    end

  end


  describe "rss_link" do

    it "is the url with safe string" do
      link = "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"RSS\" href=\"https://dyl.anjon.es/feed.rss\">"
      expect(rss_link("https://dyl.anjon.es/feed")).to eq(link)
    end

  end


  describe "get_age" do

    before do
      allow(Time).to receive(:now).and_return Time.new(2001,2,3)
    end

    it "returns my age today" do
      expect(get_age).to eq(11)
    end

  end


  describe "open_id_delegate" do

    it "provides lots of head for OpenID" do
      html = "<link rel=\"openid.server\" href=\"http://www.myopenid.com/server\">\n" +
      "<link rel=\"openid.delegate\" href=\"http://dylanjamesvernonjones.myopenid.com/\">\n" +
      "<link rel=\"openid2.local_id\" href=\"http://dylanjamesvernonjones.myopenid.com\">\n" +
      "<link rel=\"openid2.provider\" href=\"http://www.myopenid.com/server\">"
      expect(open_id_delegate).to eq(html)
    end

  end


  describe "gravatar" do

    it "returns the image html tag to display the gravatar" do
      html = "<img alt=\"Gravatar\" width=\"30\" height=\"30\" class=\"img-circle\" src=\"https://secure.gravatar.com/avatar/3184f60ba2d0eca8d4a55a8e2bbedac9.jpg?s=30&amp;d=identicon\" />"
      expect(gravatar("dyl@anjon.es")).to eq(html)
    end

  end


  describe "md5" do

    it "returns the md5 hash returned from a string" do
      md5 = "3184f60ba2d0eca8d4a55a8e2bbedac9"
      expect(md5("dyl@anjon.es")).to eq(md5)
    end

  end


  describe "error_for" do

    it "returns some fancy errors when there are errors for a model" do
      model = Account.new
      model.save
      html = "<span class=\"error_explanation\">can&#39;t be blank</span>"
      expect(errors_for(model, :name)).to eq(html)
    end

  end

end
