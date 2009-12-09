require_relative "test_helper"
require_relative "../models/test_helper"
require_relative "../../lib/cards/menu_card"
require_relative "../../lib/models/model"

class MenuCardTest < Test::Unit::CardTestCase
  def setup
    setup_card_test Messier::MenuCard
    setup_data
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

  def test_artists
    @card.list.selected_index = 0
    @card.jog_wheel_button
    assert_card Messier::ArtistsCard
  end

  def test_genres
    @card.list.selected_index = 1
    @card.jog_wheel_button
    assert_card Messier::GenresCard
  end

  def test_tracks
    @card.list.selected_index = 2
    @card.jog_wheel_button
    assert_card Messier::TracksCard
  end
end
