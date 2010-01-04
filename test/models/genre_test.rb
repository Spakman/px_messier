require_relative "test_helper"
require_relative "../../lib/models/genre"

class GenreTest < Test::Unit::TestCase
  def setup
    setup_data
  end

  def test_all
    assert_equal 4, Messier::Genre.all.length
    assert_equal "Alternative rock", Messier::Artist.get("Nirvana").albums.first.tracks.first.genre.name
  end

  def test_artists
    assert_equal [ Messier::Artist.get("Nirvana") ], Messier::Genre.get("Alternative rock").artists
    albums = Messier::Genre.get("Alternative rock").artists.first.albums
    assert_equal 1, albums.size
  end

  def test_to_s
    assert_equal "Alternative rock", Messier::Artist.get("Nirvana").albums.first.tracks.first.genre.to_s
  end

  def test_get
    genre = Messier::Genre.get("Drum and bass")
    assert_equal "Drum and bass", genre.name
  end
end
