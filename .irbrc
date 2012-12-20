require 'rubygems'

require 'irb/completion'
require 'pp'

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

if ENV['RAILS_ENV']
  load File.join( File.dirname(__FILE__), '.railsrc')
end

require 'yaml'

def v(x)
  IO.popen( 'mvim -', 'w') do |io|
    io.puts x.to_yaml
  end
end

def less(x)
  IO.popen( 'less -', 'w') do |io|
    io.puts x.to_yaml
  end
end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

