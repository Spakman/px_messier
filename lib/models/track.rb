# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require_relative "model"
require_relative "artist"
require_relative "genre"

module Messier
  class Track < Model
    attr_reader :name, :album, :artist, :genre, :id, :url

    def initialize(row)
      @name = row['track']
      @id = row[:pk]
      @album = Album.new row
      @artist = Artist.new row
      @genre = Genre.new row
      @url = row['url']
      @query = @@table.prepare_query
      @query.add_condition 'track', :equals, @name
      @query.add_condition 'album', :equals, @album.name
      @query.add_condition 'artist', :equals, @artist.name
    end

    def self.pk(key)
      row = @@table[key]
      if row
        new(row)
      end
    end

    def hash
      (@name + @album.name + @artist.name).hash
    end

    def to_s
      @name
    end
  end
end
