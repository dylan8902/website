require 'spec_helper.rb'

describe ApplicationHelper do
  
  describe "full title" do

    describe "when the title is empty" do
      it { full_title("").should eq("Dylan Jones") }
    end

    describe "when the title has a subtitle" do
      it { full_title("Test").should eq("Dylan Jones:: Test") }
    end

  end


  describe "timestamp" do

    describe "when timestamp is zero" do
      it { timestamp(0, "Unknown").should eq("Unknown") }
    end

    describe "when timestamp is in the past" do
      seconds = Time.now.to_i - 60
      time = Time.at(seconds)
      expected = "<time class=\"ago\" title=\"#{time}\" datetime=\"#{time.xmlschema}\" data-timestamp=\"#{seconds}\">1 minute ago</time>".html_safe
      it { timestamp(seconds, "Unknown").should eq(expected) }
    end

    describe "when timestamp is in the past" do
      seconds = Time.now.to_i + 60
      time = Time.at(seconds)
      expected = "<time class=\"ago\" title=\"#{time}\" datetime=\"#{time.xmlschema}\" data-timestamp=\"#{seconds}\">1 minute from now</time>".html_safe
      it { timestamp(seconds, "Unknown").should eq(expected) }
    end

  end


  describe "linkify" do

    describe "when a link is to an image" do
      link = "http://test.com/image.jpg"
      it { linkify(link).should eq("<img src=\"#{link}\">".html_safe) }
    end

    describe "when a link is to a url" do
      link = "http://test.com/"
      it { linkify(link).should eq("<a href=\"#{link}\" target=\"_blank\">#{link}</a>".html_safe) }
    end

  end


  describe "icon" do

    describe "an icon css helper" do
      it { icon("test").should eq("<i class=\"icon-test\"></i>".html_safe) }
    end

  end


  describe "distance_sql" do

    describe "the SQL calculatation for distance" do
      sql = "7912*ASIN(SQRT(POWER(SIN((lat-1.0)*pi()/180/2),2)+COS(lat*pi()/180)*COS(1.0*pi()/180)*POWER(SIN((lng-1.0)*pi()/180/2),2)))"
      it { distance_sql(1.0, 1.0).should eq(sql) }
    end

  end


  describe "rss_link" do

    describe "the html safe string" do
      link = "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"RSS\" href=\"https://dyl.anjon.es/feed.rss\">"
      it { rss_link("https://dyl.anjon.es/feed").should eq(link) }
    end

  end


  describe "get_age" do

    describe "my age today" do
      it { get_age.should eq(25) }
    end

  end


  describe "open_id_delegate" do

    describe "html head for OpenID" do
      html = "<link rel=\"openid.server\" href=\"http://www.myopenid.com/server\">\n" +
      "<link rel=\"openid.delegate\" href=\"http://dylanjamesvernonjones.myopenid.com/\">\n" +
      "<link rel=\"openid2.local_id\" href=\"http://dylanjamesvernonjones.myopenid.com\">\n" +
      "<link rel=\"openid2.provider\" href=\"http://www.myopenid.com/server\">"
      it { open_id_delegate.should eq(html) }
    end

  end


  describe "gravatar" do

    describe "the image html tag to display the gravatar" do
      html = "<img alt=\"Gravatar\" class=\"img-circle\" height=\"30\" src=\"https://secure.gravatar.com/avatar/3184f60ba2d0eca8d4a55a8e2bbedac9.jpg?s=30&amp;d=identicon\" width=\"30\" />"
      it { gravatar("dyl@anjon.es").should eq(html) }
    end

  end


  describe "md5" do

    describe "the md5 hash returned from a string" do
      md5 = "3184f60ba2d0eca8d4a55a8e2bbedac9"
      it { md5("dyl@anjon.es").should eq(md5) }
    end

  end


  describe "error_for" do

    describe "when there are errors for a model" do
      model = Account.new
      model.save
      html = "<span class=\"error_explanation\">can&#39;t be blank</span>"
      it { errors_for(model, :name).should eq(html) }
    end

  end

end