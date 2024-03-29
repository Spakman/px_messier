require_relative "test_helper"
require_relative "../../lib/models/album"

class AlbumTest < Test::Unit::TestCase
  def setup
    setup_data
  end

  def test_equality
    spakman_hits = Messier::Album.new name: "Greatest Hits", artist: "Spakman"
    nunpuncher_hits = Messier::Album.new name: "Greatest Hits", artist: "Nunpuncher"
    refute_equal spakman_hits, nunpuncher_hits
  end

  def test_uniq
    spakman_hits = Messier::Album.new name: "Greatest Hits", artist: "Spakman"
    nunpuncher_hits = Messier::Album.new name: "Greatest Hits", artist: "Nunpuncher"
    assert_equal 2, [ spakman_hits, nunpuncher_hits ].uniq.size
  end
  
  def test_all
    assert_equal 4, Messier::Album.all.length
    assert_equal "Bleach", Messier::Album.all.first.name
  end

  def test_artist
    assert_equal Messier::Artist.get("Nirvana"), Messier::Album.all.first.artist
  end

  def test_tracks_are_ordered_by_track_nr
    tracks = Messier::Album.all.last.tracks
    assert_equal "In Bloom", tracks.first.to_s
    assert_equal "Stay Away", tracks.last.to_s
  end

  def test_tracks_limited_by_genre
    artist = Messier::Artist.get("Nirvana")
    artist.genre = Messier::Genre.get("Alternative rock")
    assert_equal 1, artist.albums.first.tracks.size
  end

  def test_to_s
    assert_equal "Nevermind", Messier::Album.all.last.to_s
  end
end
