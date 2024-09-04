Pry::Commands.block_command '!!' do
  Rails.application.reloader.reload!
end  

Pry::Commands.block_command 'r' do |*w|
  run "show-routes" + ( w.present? ? " --grep '#{w.join ' '}'" : "" )
end

Pry::Commands.block_command "rg" do |w|
  run %{.rg '#{w}'}
end

Pry::Commands.block_command ".." do |w|
  run %{cd ..}
end

Pry::Commands.block_command "..." do |w|
  run %{cd ../..}
end

Pry::Commands.block_command "...." do |w|
  run %{cd ../../..}
end

if defined? FactoryGirl
  %i[create build].each do |meth|
    define_method meth, -> (*args) { FactoryGirl.send meth, *args }
  end
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'

  Pry::Commands.command /^$/, "repeat last command" do
    pry_instance.run_command Pry.history.to_a.last
  end
  
end

Pry.config.prompt = Pry::Prompt.new(
  "mine",
  "My custom prompt",
  [ proc { |obj, nest_level, _|
    nest_string = nest_level > 0 ? ":#{nest_level}" : ""
    obj_string = obj.to_s + nest_string + " "
    obj_string = "" if obj_string == "main "

    cgb = `git rev-parse --abbrev-ref HEAD`.chomp

    color =
      case Rails.env
      when "development"
        "32"
      when "test"
        "34"
      else
        "31"
      end


    "\e[#{color}m#{obj_string}#{cgb} ⟩\e[0m "
  }]
)

Pry.config.output_prefix = ""

# vim: ft=ruby
