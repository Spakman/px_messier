# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "artists_card"
require_relative "genres_card"
require_relative "../models/artist"

module Messier
  class Messier::MenuCard < Spandex::ListCard
    top_left :back
    jog_wheel_button method: -> do
      case @list.selected
      when "Tracks"
        load_card Messier::TracksCard
      when "Artists"
        load_card Messier::ArtistsCard
      when "Albums"
        load_card Messier::AlbumsCard
      when "Genres"
        load_card Messier::GenresCard
      end
    end

    def after_initialize
      @list ||= Spandex::List.new [ "Artists", "Genres", "Albums", "Tracks" ]
    end

    def show
      render "<button position=\"top_left\">Back</button><title>Mark's music</title>#{@list}"
    end
  end
end
