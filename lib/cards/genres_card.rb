# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/genre"
require_relative "artists_card"

module Messier
  class Messier::GenresCard < Spandex::Card
    include JogWheelListMethods

    top_left :back

    jog_wheel_button card: Messier::ArtistsCard, params: -> do
      { genre: @list.selected }
    end

    def after_initialize
      @list ||= Spandex::List.new Genre.all
      @title = "Genre"
    end

    def show
      render %{
        <title>Genres</title>
        <button position="top_left">Back</button>
        #{@list}
      }
    end
  end
end
