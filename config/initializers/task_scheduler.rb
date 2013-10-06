require 'rubygems'
require 'rufus/scheduler'  
scheduler = Rufus::Scheduler.start_new

scheduler.cron '2 * * * *' do
    Photo.update
    Tweet.update
    Listen.update
end

scheduler.cron '2 * * * *' do
  BbcTwitter.update
end