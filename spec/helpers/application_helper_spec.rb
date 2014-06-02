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
  
  
end