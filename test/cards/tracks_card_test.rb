require_relative "test_helper"
require_relative "../models/test_helper"
require_relative "../../lib/cards/tracks_card"

class TracksCardTest < Test::Unit::CardTestCase
  def setup
    setup_card_test Messier::TracksCard
    setup_data
  end

  def teardown
    FileUtils.rm "/tmp/#{File.basename($0)}.socket"
  end

  def test_show_all
    @card.call_show_chain
    assert_match %r{<title>All tracks</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){5}}m, rendered
    assert_equal 9, @card.list.items.size
  end

  def test_show_tracks_for_artist_album
    nirvana = Messier::Artist.get("Nirvana")
    @card.params = { artist: nirvana, album: nirvana.albums.first }
    @card.call_show_chain
    assert_match %r{<title>Nirvana -> Bleach</title>}m, rendered
    assert_match /<list>/, rendered
    assert_match /<button position="top_left">Back<\/button>/, rendered
    assert_match /<button position="bottom_left">Queue all<\/button>/, rendered
    assert_match /<button position="bottom_right">Queue track<\/button>/, rendered
    assert_match %r{(<item.*>.+</item>.*){2}}m, rendered
    assert_equal 2, @card.list.items.size
  end

  def test_show_tracks_for_genre_artist_album
    nirvana = Messier::Artist.get("Nirvana")
    @card.params = { artist: nirvana, album: nirvana.albums.first, genre: nirvana.albums.first.tracks.first.genre }
    @card.call_show_chain
    assert_match %r{<title>Alternative rock -> .. -> Bleach</title>}m, rendered
  end

  def test_select_tracks
    @card.list.selected_index = 3
    @card.jog_wheel_button
    assert_pass_focus application: "mozart", method: "play_ids", params: "7, 0, 8, 2, 3, 5"
  end

  def test_queue_track
    @card.bottom_right
    assert_pass_focus application: "mozart", method: "queue_ids", params: 4
  end

  def test_queue_all_tracks
    @card.bottom_left
    assert_pass_focus application: "mozart", method: "queue_ids", params: "4, 6, 1, 7, 0, 8, 2, 3, 5"
  end
end
