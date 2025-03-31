ENV["RUBYOPT"] = nil

gem_group :development do
  gem "simplecov"
  gem "pry-rails"
  gem "better_errors"
  gem "ruby-lsp"
  gem "html2slim", github: "slim-template/html2slim"
end

%w[web-console jbuilder sdoc rubocop].each do |gem|
  gsub_file "Gemfile", /(?:\s*^\s*#.*\n)*\s*gem ['"]#{gem}.*\n+/, "\n"
end

%w[mysql2 pg].each do |gem|
  gsub_file "Gemfile", /^gem ['"]sqlite.*/, %{\\&\ngem "#{gem}"}
end

%w[slim-rails argon2].each do |gem|
  gsub_file "Gemfile", /^# gem ['"]bcrypt.*/, %{\\&\ngem "#{gem}"}
end

gsub_file "Gemfile", /\n*^group.*do$\s*^end$\n*/, "\n\n"

after_bundle do
  source_paths << __dir__
  copy_file "database.yml", "config/database.yml", force: true
  %w[pg mysql].each do |adapter|
    run %{RAILS_ADAPTER=#{adapter} rails db:create}
  end
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
