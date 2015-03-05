gem 'haml-rails'
gem 'jquery-ui-rails'

gem_group :development, :test do
  gem 'tapout'
  gem 'minitap'
  gem 'pry-rails'
  gem 'simplecov'
end

gem_group :development do
  gem 'better_errors'
end

after_bundle do
  run %{sed -i'' test/test_helper.rb -e"/ENV/r #{File.expand_path '../test_helper.snippet.rb', __FILE__}"}

  run %{sed -i'' Rakefile -e"/Rails.application.load_tasks/r #{File.expand_path '../Rakefile.snippet', __FILE__}" -e"/Rails.application.load_tasks/d"}
end
