%w[haml-rails jquery-ui-rails simple_form responders bootstrap-sass rabl-rails trailblazer-rails trailblazer cells cells-haml].each do |gem|
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
  inside "app/assets/stylesheets" do
    remove_file %{application.css}
    file="application.scss"
    create_file file
    append_to_file file, %{@import "bootstrap-sprockets";\n@import "bootstrap";\n}
  end

  inside "app/assets/javascripts" do
    insert_into_file "application.js", "//= require bootstrap-sprockets\n", after: "require jquery\n"
  end

  run %{rails g simple_form:install --force --bootstrap}
  run %{rails g responders:install --force}

  inside "app/views/layouts" do
    file = "application.html.erb"
    run %{html2haml #{file} application.haml && rm #{file}}
  end

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
