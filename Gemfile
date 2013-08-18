source 'https://rubygems.org'

# Specify your gem's dependencies in complex_form.gemspec
gemspec

group :test do
  gem 'rspec', '~> 2.14.0'
  gem 'ffaker', '~> 1.18.0'
end

platforms :mri_19 do
  gem 'debugger'
end

platforms :mri_20 do
  gem 'byebug'
end
