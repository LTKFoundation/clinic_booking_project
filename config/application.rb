require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ClinicBooking
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Overwrite Rails config for wrapping error field
    # Read more http://stackoverflow.com/questions/5267998/rails-3-field-with-errors-wrapper-changes-the-page-appearance-how-to-avoid-t#5268106
    Rails.application.config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag
    end

    # TODO Use env variable for this config
    Rails.application.config.action_mailer.delivery_method = :smtp
    Rails.application.config.action_mailer.smtp_settings = {
      address:              'smtp.sendgrid.net',
      port:                 25,
      user_name:            'apikey',
      password:             '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',
      authentication:       'plain'
    }

  end
end

