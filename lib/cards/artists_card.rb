# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/artist"
require_relative "albums_card"

module Messier
  class Messier::ArtistsCard < Spandex::ListCard
    top_left :back

    jog_wheel_button card: Messier::AlbumsCard, params: -> do
      if params[:genre]
        { artist: @list.selected, genre: params[:genre] }
      else
        { artist: @list.selected }
      end
    end

    top_right :method => :play_all

    def play_all
      ids = []
      @list.items.each do |artist| 
        artist.albums.each { |a| ids += a.tracks.map(&:id) }
      end
      pass_focus(application: "mozart", method: "play_ids", params: ids.join(", "))
    end

    def after_initialize
      @list ||= Spandex::List.new Artist.all
      @title = "All artists"
    end

    def after_load
      if params[:genre]
        @list = Spandex::List.new params[:genre].artists
        @title = "#{params[:genre].name}"
      else
        @list = Spandex::List.new Artist.all
        @title = "All artists"
      end
    end

    def show
      render %{
        <title>#{@title}</title>
        <button position="top_left">Back</button>
        <button position="top_right">Play all</button>
        #{@list}
      }
    end
  end
end
