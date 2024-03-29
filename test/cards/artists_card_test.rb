require_relative "test_helper"
require_relative "../models/test_helper"
require_relative "../../lib/cards/artists_card"
require_relative "../../lib/models/model"

class ArtistsCardTest < Test::Unit::CardTestCase
  def setup
    setup_card_test Messier::ArtistsCard
    setup_data
  end

  def teardown
    FileUtils.rm "/tmp/#{File.basename($0)}.socket"
  end

  def test_show_all
    @card.call_show_chain
    assert_match %r{<title>All artists</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){2}}m, rendered
    assert_equal 3, @card.list.items.size
  end

  def test_show_artists_for_genre
    @card.params = { genre: Messier::Genre.get("Drum and bass") }
    @card.call_show_chain
    assert_match %r{<title>Drum and bass</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){1}}m, rendered
    assert_equal 1, @card.list.items.size
  end

  def test_select_artist
    @card.jog_wheel_button
    assert_card Messier::AlbumsCard, artist: Messier::Artist.get("king unique")
  end

  def test_select_artist_for_genre
    @card.params = { genre: Messier::Genre.get("Grunge") }
    @card.jog_wheel_button
    assert_card Messier::AlbumsCard, { artist: Messier::Artist.get("Nirvana"), genre: Messier::Genre.get("Grunge") }
  end

  def test_play_all_artists
    @card.top_right
    assert_pass_focus application: "mozart", method: "play_ids", params: "8, 6, 7, 0, 1, 2, 5, 3, 4"
  end
end
