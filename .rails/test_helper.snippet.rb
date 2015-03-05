
require 'minitest/autorun'
require 'minitap'

if defined? Minitap
  Minitest.reporter = Minitap::TapY
else
  MiniTest::Unit.runner = MiniTest::TapY.new
end

