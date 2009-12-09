require_relative "test_helper"
require_relative "../../lib/models/track"

class TrackTest < Test::Unit::TestCase
  def setup
    setup_data
  end

  def test_all
    assert_equal 8, Messier::Track.all.length
    assert_equal "Blew", Messier::Artist.get("Nirvana").albums.first.tracks.first.name
  end

  def test_artist
    track = Messier::Artist.get("Nirvana").albums.first.tracks.first
    assert_equal Messier::Artist.get("Nirvana"), track.artist
    assert_equal "6", track.id
  end

  def test_genre
    track = Messier::Artist.get("Nirvana").albums.first.tracks.first
    assert_equal "Alternative rock", track.genre.name
  end

  def test_to_s
    track = Messier::Artist.get("Nirvana").albums.first.tracks.first
    assert_equal "Blew", track.to_s
  end
end
