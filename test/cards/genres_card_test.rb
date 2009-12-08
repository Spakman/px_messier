require_relative "test_helper"
require_relative "../models/test_helper"
require_relative "../../lib/cards/genres_card"
require_relative "../../lib/models/model"

class GenresCardTest < Test::Unit::CardTestCase
  def setup
    setup_card_test Messier::GenresCard
    setup_data
  end

  def teardown
    FileUtils.rm "/tmp/#{File.basename($0)}.socket"
  end

  def test_show
    @card.show
    assert_match %r{<title>Genres</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){2}}m, rendered
    assert_equal 2, @card.list.items.size
  end

  def test_select_genre
    @card.jog_wheel_button
    assert_card Messier::ArtistsCard, genre: Messier::Genre.get("Drum and bass")
  end
end
