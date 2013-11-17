require 'rubygems'
require 'rufus/scheduler'  
scheduler = Rufus::Scheduler.start_new

scheduler.cron '2 * * * *' do
  Photo.update
  Tweet.update
  Listen.update
  BbcTwitter.update
  Location.update
end