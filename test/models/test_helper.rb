$LOAD_PATH.unshift "#{ENV['PROJECT_X_BASE']}/lib/"
require "rubygems"
require "rufus/tokyo"
require "fileutils"
require "test/unit"

TABLE_FILEPATH = "#{File.dirname(__FILE__)}/testtable.tct"

def setup_data
  Messier::Model.close_table
  @table = Rufus::Tokyo::Table.new(TABLE_FILEPATH)
  @table[0] = { 'artist' => 'Nirvana', 'album' => 'Nevermind', 'track' => 'In Bloom', 'genre' => 'Grunge', 'track_nr' => '2' }
  @table[1] = { 'artist' => 'Nirvana', 'album' => 'Nevermind', 'track' => 'Breed', 'genre' => 'Grunge', 'track_nr' => '4' }
  @table[6] = { 'artist' => 'Nirvana', 'album' => 'Bleach', 'track' => 'Blew', 'genre' => 'Alternative rock', 'track_nr' => '1' }
  @table[7] = { 'artist' => 'Nirvana', 'album' => 'Bleach', 'track' => 'Floyd the Barber', 'genre' => 'Grunge', 'track_nr' => '2' }
  @table[2] = { 'artist' => 'Nirvana', 'album' => 'Nevermind', 'track' => 'Lithium', 'genre' => 'Grunge', 'track_nr' => '5' }
  @table[5] = { 'artist' => 'Nirvana', 'album' => 'Nevermind', 'track' => 'Stay Away', 'genre' => 'Grunge', 'track_nr' => '10' }
  @table[3] = { 'artist' => 'Pendulum', 'album' => 'Hold Your Colour', 'track' => 'Slam', 'genre' => 'Drum and bass' }
  @table[4] = { 'artist' => 'Pendulum', 'album' => 'Hold Your Colour', 'track' => 'Another Planet', 'genre' => 'Drum and bass' }
  @table[8] = { 'artist' => 'king unique', 'album' => 'Essential Mixes', 'track' => 'King Unique 31/10/1004', 'genre' => 'House' }
  @table.close
  Messier::Model.open_table
end
