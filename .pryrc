Pry::Commands.block_command '!!' do
  ActionDispatch::Reloader.cleanup!      
  ActionDispatch::Reloader.prepare!      
end  

Pry::Commands.block_command 'r' do |*w|
  run "show-routes" + ( w.present? ? " --grep '#{w.join ' '}'" : "" )
end
