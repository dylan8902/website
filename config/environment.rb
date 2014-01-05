# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Website::Application.initialize!

Mime::Type.register "application/rss+xml", :rss