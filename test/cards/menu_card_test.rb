require "rubygems"
require "fileutils"
require_relative "test_helper"
require_relative "../../lib/cards/menu_card"

class MenuCardTest < Test::Unit::CardTestCase
  def setup
    setup_card_test Messier::MenuCard
  end

  def teardown
    FileUtils.rm "/tmp/#{File.basename($0)}.socket"
  end

  def test_show
    @card.show
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){3}}m, rendered
    assert_equal 3, @card.list.items.size
  end
end
