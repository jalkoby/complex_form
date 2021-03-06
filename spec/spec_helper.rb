require 'bundler/setup'
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/examples/**/*.rb'].each { |f| require f }

I18n.load_path << File.dirname(__FILE__) + '/examples/complexform.yml'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
