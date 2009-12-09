require_relative "test_helper"
require_relative "../models/test_helper"
require_relative "../../lib/cards/albums_card"
class AlbumsCardTest < Test::Unit::CardTestCase
  def setup
    setup_card_test Messier::AlbumsCard
    setup_data
  end

  def teardown
    FileUtils.rm "/tmp/#{File.basename($0)}.socket"
  end

  def test_show_all
    @card.show
    assert_match %r{<title>All albums</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){2}}m, rendered
    assert_equal 2, @card.list.items.size
  end

  def test_show_albums_for_artist
    @card.params = { artist: Messier::Artist.get("Nirvana") }
    @card.show
    assert_match %r{<title>Nirvana</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){1}}m, rendered
    assert_equal 1, @card.list.items.size
  end

  def test_show_albums_for_artist_under_genre
    @card.params = { genre: Messier::Genre.get("Grunge"), artist: Messier::Artist.get("Nirvana") }
    @card.show
    assert_match %r{<title>Grunge -> Nirvana</title>}m, rendered
  end

  def test_select_album
    nirvana = Messier::Artist.get("Nirvana")
    @card.params = { artist: nirvana }
    @card.jog_wheel_button
    assert_card Messier::TracksCard, { artist: nirvana, album: nirvana.albums.first }
  end
end
