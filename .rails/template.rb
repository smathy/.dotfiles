%w[slim-rails argon2].each do |gem|
  gem "#{gem}"
end

gem_group :development do
  gem "simplecov"
  gem "pry-rails"
  gem "better_errors"
  gem "ruby-lsp"
  gem "binding_of_caller"
  gem "html2slim", github: "slim-template/html2slim"
end

%w[web-console jbuilder sdoc].each do |gem|
  gsub_file "Gemfile", /(?:^[ \t]*#.*\n)?^.*#{gem}.*\n+/, ''
end

after_bundle do
  run %{bundle binstubs html2slim}
  run %{for f in app/views/layouts/*.html.erb; do erb2slim -d $f; done}
  git add: '.'
  git commit: %{ -m init }
end

inject_into_class "config/application.rb", "Application", <<-EOI
    config.generators do |g|
      g.test_framework  :test_unit, fixture: false
    end
EOI
