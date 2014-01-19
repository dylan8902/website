require 'coderay'
class HybridRadio::RadioEpgController < ApplicationController

  # GET /hybrid/epg
  # GET /hybrid/epg.json
  # GET /hybrid/epg.xml
  def index
    xml_block = <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<epg xml:lang="en" xmlns="http://www.worlddab.org/schemas/epgSchedule/14" xmlns:epg="http://www.worlddab.org/schemas/epgDataTypes/14" xmlns:repg="http://schemas.radiodns.org/epg/10" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.worlddab.org/schemas/epgSchedule/14 http://www.worlddab.org/schemas/epgSchedule/14/epgSchedule_14.xsd">
 <schedule creationTime="2014-01-19T13:20:32" originator="Global Radio" version="1">
  <scope startTime="2014-01-19T00:00:00+00:00" stopTime="2014-01-20T00:00:00+00:00">
   <serviceScope id="e1.c181.c2a1.0"/>
   <serviceScope id="e1.c193.c2a1.0"/>
  </scope>
  <programme id="crid://epg.musicradio.com/programmes/191/1882227" shortId="1882227">
   <epg:mediumName>Laurence</epg:mediumName>
   <epg:longName>Laurence Llewelyn Bowen</epg:longName>
   <epg:location>
    <epg:time actualDuration="PT3H" actualTime="2014-01-19T12:00:00+00:00" duration="PT3H" time="2014-01-19T12:00:00+00:00"/>
   </epg:location>
   <epg:mediaDescription>
    <epg:longDescription>The perfect soundtrack to your Sunday afternoon, Laurence plays three hours of relaxing and re-invigorating classical music.</epg:longDescription>
   </epg:mediaDescription>
   <epg:memberOf id="crid://epg.musicradio.com/programmes/191" shortId="191"/>
   <epg:link description="Web:" url="http://www.classicfm.com/radio/shows/laurence-llewelyn-bowen"/>
   <mediaDescription>
    <epg:multimedia height="320" type="logo_unrestricted" url="http://mediaweb.musicradio.com/ArtWork/SES/db85a7d8-004a-4f5a-a6e2-0dc6bc86f5cb.png" width="600"/>
   </mediaDescription>
   <mediaDescription>
    <epg:multimedia height="2048" type="logo_unrestricted" url="http://mediaweb.musicradio.com/ArtWork/SES/8f631b6f-b184-442b-9fd7-c134b04cbe51.jpg" width="2048"/>
   </mediaDescription>
  </programme>
  <programme id="crid://epg.musicradio.com/programmes/3055/1882228" shortId="1882228">
   <epg:mediumName>Culture Club</epg:mediumName>
   <epg:longName>Charlotte Green's Culture Club</epg:longName>
   <epg:location>
    <epg:time actualDuration="PT2H" actualTime="2014-01-19T15:00:00+00:00" duration="PT2H" time="2014-01-19T15:00:00+00:00"/>
   </epg:location>
   <epg:mediaDescription>
    <epg:longDescription>Join Charlotte Green for the latest news and reviews from the arts world and a very special guest.</epg:longDescription>
   </epg:mediaDescription>
   <epg:memberOf id="crid://epg.musicradio.com/programmes/3055" shortId="3055"/>
   <epg:link description="Web:" url="http://www.classicfm.com/radio/shows/charlotte-greens-culture-club"/>
   <mediaDescription>
    <epg:multimedia height="320" type="logo_unrestricted" url="http://mediaweb.musicradio.com/ArtWork/SES/2b0a7c6e-c6c5-4e52-9b22-812f4c599573.png" width="600"/>
   </mediaDescription>
   <mediaDescription>
    <epg:multimedia height="2048" type="logo_unrestricted" url="http://mediaweb.musicradio.com/ArtWork/SES/a3d4d45f-e41c-4541-a903-6b913460644a.jpg" width="2048"/>
   </mediaDescription>
  </programme>
  <programme id="crid://epg.musicradio.com/programmes/183/1882229" shortId="1882229">
   <epg:mediumName>Chart Show</epg:mediumName>
   <epg:longName>The Classic FM Chart</epg:longName>
   <epg:location>
    <epg:time actualDuration="PT2H" actualTime="2014-01-19T17:00:00+00:00" duration="PT2H" time="2014-01-19T17:00:00+00:00"/>
   </epg:location>
   <epg:mediaDescription>
    <epg:longDescription>Tune in to the Classic FM Chart every Sunday between 5pm and 7pm, when we count down the 30 biggest classical albums in the UK.</epg:longDescription>
   </epg:mediaDescription>
   <epg:memberOf id="crid://epg.musicradio.com/programmes/183" shortId="183"/>
   <epg:link description="Web:" url="http://www.classicfm.com/radio/shows/official-classic-fm-chart"/>
   <mediaDescription>
    <epg:multimedia height="320" type="logo_unrestricted" url="http://mediaweb.musicradio.com/ArtWork/SES/76c97711-3829-4596-a45b-e63b074f3572.png" width="600"/>
   </mediaDescription>
   <mediaDescription>
    <epg:multimedia height="2048" type="logo_unrestricted" url="http://mediaweb.musicradio.com/ArtWork/SES/8d650c57-29b6-4976-81d4-679e84cd971f.png" width="2048"/>
   </mediaDescription>
  </programme>
 </schedule>
</epg>
EOS
    @h = CodeRay.scan(xml_block, :xml).div.html_safe

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result, callback: params[:callback] }
      format.xml { render xml: @result }
    end
  end


end