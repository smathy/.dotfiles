%w[slim-rails rabl-rails argon2].each do |gem|
  gem "#{gem}"
end

gem_group :development do
  gem "simplecov"
  gem "pry-rails"
  gem "better_errors"
  gem "binding_of_caller"
  gem "html2slim"
end

%w[web-console jbuilder sdoc].each do |gem|
  gsub_file "Gemfile", /(?:^[ \t]*#.*\n)?^.*#{gem}.*\n+/, ''
end

after_bundle do
  # run %{rails g simple_form:install --force}
  run %{erb2slim app/views/layouts/application.html.erb}
  run %{rm app/views/layouts/application.html.erb}
  git :init
  git add: '.'
  git commit: %{ -m init }
end

inject_into_class "config/application.rb", "Application", <<-EOI
    config.generators do |g|
      g.test_framework  :test_unit, fixture: false
    end
EOI
