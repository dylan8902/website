require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Include generic and useful information about system operation, but avoid logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII).
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "testy_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :sendmail

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new "app-name")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.hosts << "isitaproxyproblem.com"
  config.hosts << "www.isitaproxyproblem.com"
  config.hosts << "unexpectedgems.com"
  config.hosts << "www.unexpectedgems.com"
  config.hosts << "luxurylollipops.com"
  config.hosts << "www.luxurylollipops.com"
  config.hosts << "armyarmyarmyarmyaryarmyarmy.com"
  config.hosts << "www.armyarmyarmyarmyaryarmyarmy.com"
  config.hosts << "keepintouchabroad.com"
  config.hosts << "www.keepintouchabroad.com"
  config.hosts << "hiddengifts.co.uk"
  config.hosts << "www.hiddengifts.co.uk"
  config.hosts << "stjohn.dyl.anjon.es"
  config.hosts << "www.stjohn.dyl.anjon.es"
  config.hosts << "intothewoodsyork.dyl.anjon.es"
  config.hosts << "westsidestory2013.dyl.anjon.es"
  config.hosts << "westsidestory.dyl.anjon.es"
  config.hosts << "ismytraindelayed.com"
  config.hosts << "www.ismytraindelayed.com"
  config.hosts << "ismybusdelayed.com"
  config.hosts << "www.ismybusdelayed.com"
  config.hosts << "ismyplanedelayed.com"
  config.hosts << "www.ismyplanedelayed.com"
  config.hosts << "dylanjones.info"
  config.hosts << "www.dylanjones.info"
  config.hosts << "api.dylanjones.info"
  config.hosts << "dyl.anjon.es"
  config.hosts << "www.dyl.anjon.es"

  config.base_url = "https://dyl.anjon.es"
end
