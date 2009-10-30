require "rubygems"
require "rufus/tokyo"
require "test/unit"
require_relative "test_helper"
require_relative "../lib/album"

class AlbumTest < Test::Unit::TestCase
  def setup
    setup_data
  end
  
  def test_all
    assert_equal 2, Messier::Album.all.length
    assert_equal "Hold Your Colour", Messier::Album.all.first.name
  end

  def test_artist
    assert_equal Messier::Artist.get("Pendulum"), Messier::Album.all.first.artist
  end

  def test_tracks_are_ordered_by_track_nr
    tracks = Messier::Album.all.last.tracks
    assert_equal "In Bloom", tracks.first.to_s
    assert_equal "Stay Away", tracks.last.to_s
  end

  def test_to_s
    assert_equal "Nevermind", Messier::Album.all.last.to_s
  end
end
