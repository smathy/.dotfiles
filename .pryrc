# frozen_string_literal: true

Pry::Commands.command '!!' do |*args|
  if args.empty?
    Rails.application.reloader.reload!
  else
    args.each do |arg|
      run "reload-code #{arg}"
    end
  end
end  

Pry::Commands.command "b" do |w|
  require "debug"
  if w
    ::DEBUGGER__::SESSION.repl_add_breakpoint w
  else
    ::DEBUGGER__::SESSION.show_bps
  end
end

Pry::Commands.command "del" do |w|
  require "debug"
  ::DEBUGGER__::SESSION.delete_bp w.to_i
end

Pry::Commands.command 'r' do |*w|
  run "show-routes" + ( w.present? ? " --grep '#{w.join ' '}'" : "" )
end

Pry::Commands.command "rg" do |w|
  run %{.rg '#{w}'}
end

Pry::Commands.command ".." do |w|
  run %{cd ..}
end

Pry::Commands.command "..." do |w|
  run %{cd ../..}
end

Pry::Commands.command "...." do |w|
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


    "\e[34m#{obj_string}\e[#{color}m#{cgb} ⟩\e[0m "
  }]
)

Pry.config.output_prefix = ""

# vim: ft=ruby
