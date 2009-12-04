$LOAD_PATH.unshift "#{ENV['PROJECT_X_BASE']}/lib/"
require "test/unit"
require "spandex/application"
require "spandex/card"
require "spandex/list"

class Spandex::ListCard < Spandex::Card
  attr_reader :list
end

class Spandex::List
  attr_reader :items
end

class TestApplication < Spandex::Application; end

class Test::Unit::CardTestCase < Test::Unit::TestCase
  def setup_card_test(card)
    TestApplication.entry_point card.to_s
    @rendered = ""
    FileUtils.rm_f "/tmp/#{File.basename($0)}.socket"
    UNIXServer.open "/tmp/#{File.basename($0)}.socket"
    @application = TestApplication.new
    @card = card.new @rendered, @application
  end

  def rendered
    @rendered.sub /^<render \d+>\n/, ""
  end
end
