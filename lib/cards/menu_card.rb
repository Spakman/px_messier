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
      when "Play all"
        pass_focus application: "mozart", method: "play_ids", params: Messier::Track.all.map(&:id).join(", ")
      when "Artists"
        load_card Messier::ArtistsCard
      when "Genres"
        load_card Messier::GenresCard
      end
    end

    def after_initialize
      @list ||= Spandex::List.new [ "Artists", "Genres", "Play all" ]
    end

    def show
      render "<button position=\"top_left\">Back</button><title>Mark's music</title>#{@list}"
    end
  end
end
