$LOAD_PATH.unshift "#{ENV['PROJECT_X_BASE']}/lib/"
require "test/unit"
require "fileutils"
require "spandex/application"
require "spandex/card"
require "spandex/list"
require "honcho/message"

class Spandex::Card
  def ==(object)
    if object.kind_of? Spandex::Card
      self.class == object.class
    else
      false
    end
  end
end

class Spandex::ListCard < Spandex::Card
  attr_reader :list
end

class Spandex::List
  attr_reader :items
  attr_accessor :selected_index
end

class TestApplication < Spandex::Application
  attr_reader :cards
end

class Test::Unit::CardTestCase < Test::Unit::TestCase
  def setup_card_test(card)
    TestApplication.entry_point card
    @socket_string = ""
    FileUtils.rm_f "/tmp/#{File.basename($0)}.socket"
    UNIXServer.open "/tmp/#{File.basename($0)}.socket"
    @application = TestApplication.new
    @card = card.new @socket_string, @application
  end

  def rendered
    @socket_string.sub /^<render \d+>\n/, ""
  end

  def assert_card(card, params = nil)
    message = "Expected active Card to be #{card}, but it was #{@application.cards.last}"
    assert_block(message) { @application.cards.last.class == card}

    if params
      message = "Expected card params to be #{params}, but there were #{@application.cards.last.params}"
      assert_block(message) { @application.cards.last.params == params}
    end
  end

  def assert_pass_focus(options = {})
    type = @socket_string[/^<(\w+) \d+>\n(.+)$/m, 1]
    body = $2
    message = Honcho::Message.new type, body

    error = "Expected focus to be passed, but it was not"
    assert_block(error) { message.type == :passfocus }

    if options[:application]
      error = "Expected focus to be passed to '#{options[:application]}' but it was passed to '#{message.body["application"]}'"
      assert_block(error) { message.body["application"] == options[:application] }
    end

    if options[:method]
      error = "Expected called method to be '#{options[:method]}' but it was '#{message.body["method"]}'"
      assert_block(error) { message.body["method"] == options[:method] }
    end

    if options[:params]
      error = "Expected called params to be '#{options[:params]}' but it was '#{message.body["params"]}'"
      assert_block(error) { message.body["params"] == options[:params] }
    end
  end
end
