require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Partyup
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    config.assets.precompile += [ 'plugins/bootstrap3-wysihtml5/bootstrap3-wysihtml5.all.min.js', 'bootstrap3-wysihtml5/bootstrap3-wysihtml5.min.css', 
                                  'plugins/jquery-validation/jquery.validate.js', 'plugins/jquery-validation/additional-methods.js', 'plugins/jquery-validation/custom-methods.js',
                                  'plugins/bootstrap-datepicker/bootstrap-datepicker.js', 'datepicker3/datepicker3.css', 
                                  'plugins/bootstrap-timepicker/bootstrap-timepicker.js', 'bootstrap-timepicker/bootstrap-timepicker.css',
                                  'plugins/jquery-inputmask/jquery.inputmask.js', 'plugins/jquery-inputmask/jquery.inputmask.extensions.js',
                                  'plugins/bootstrap-tagsinput/bootstrap-tagsinput.js', 'bootstrap-tagsinput/bootstrap-tagsinput.css',
                                  'plugins/flexslider/jquery.flexslider.js', 'flexslider/flexslider.css',
                                  'active_admin/active_admin.js', 'active_admin/active_admin.css' ]
    
  end
end
