%w[slim-rails jquery-ui-rails simple_form responders rabl-rails].each do |gem|
  gem "#{gem}"
end

gem_group :development, :test do
  gem "tapout"
  gem "minitap"
end

gem_group :development do
  gem "simplecov"
  gem "pry-rails"
  gem "better_errors"
end

%w[web-console jbuilder sdoc].each do |gem|
  gsub_file "Gemfile", /(?:^[ \t]*#.*\n)?^.*#{gem}.*\n+/, ''
end

%w[bcrypt capistrano-rails].each do |re|
  uncomment_lines "Gemfile", re
end

after_bundle do
  run %{rails g simple_form:install --force}
  run %{rails g responders:install --force}
  run %{erb2slim app/views/layouts/application.html.erb && rm app/views/layouts/application.html.erb}
  git :init
  git add: '.'
  git commit: %{ -m init }
end

inside 'test' do
  req = "tap_helper"
  insert_into_file "test_helper.rb", %{require "tap_helper"\n\n}, :before => "class ActiveSupport::TestCase"

  file req + ".rb", <<-EOI.strip_heredoc
    require "minitest/autorun"
    require "minitap"

    Minitest.reporter = Minitap::TapY
  EOI
end


inject_into_class "config/application.rb", "Application", <<-EOI
    config.generators.test_unit[:fixture] = false
EOI
