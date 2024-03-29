# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require_relative "model"
require_relative "artist"
require_relative "track"

module Messier
  class Album < Model
    attr_reader :name, :artist

    def initialize(row)
      @name = row['album'] || row[:artist]
      @artist = Artist.new row
      @query = @@table.prepare_query
      @query.add_condition 'album', :equals, @name
      @query.add_condition 'artist', :equals, @artist.name
    end

    # Adds a condition to limit database pulls to a genre.
    def genre=(genre)
      @genre = genre
      @query.add_condition 'genre', :equals, genre.name
    end

    def hash
      (@name + @artist.name).hash
    end

    def tracks
      tracks = []
      @query.order_by 'track_nr', :numasc
      @query.run.each do |row|
        tracks << Track.new(row)
      end
      tracks.uniq
    end

    def to_s
      @name
    end
  end
end
