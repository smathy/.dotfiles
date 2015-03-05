Pry::Commands.block_command '!!' do
  ActionDispatch::Reloader.cleanup!      
  ActionDispatch::Reloader.prepare!      
end  

Pry::Commands.block_command 'r' do |*w|
  run "show-routes" + ( w.present? ? " --grep '#{w.join ' '}'" : "" )
end

if defined? FactoryGirl
  %i[create build].each do |meth|
    define_method meth, -> (*args) { FactoryGirl.send meth, *args }
  end
end
