# Load the Rails application.
require File.expand_path('../application', __FILE__)

Mime::Type.register "application/rss+xml", :rss

# Initialize the Rails application.
Website::Application.initialize!

