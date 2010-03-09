# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/artist"
require_relative "tracks_card"

module Messier
  class Messier::AlbumsCard < Spandex::Card
    include JogWheelListMethods

    top_left :back

    jog_wheel_button card: Messier::TracksCard, params: -> do
      if params and params[:genre]
        { genre: params[:genre], artist: params[:artist], album: @list.selected }
      else
        { album: @list.selected, artist: @list.selected.artist }
      end
    end

    top_right :method => :play_all

    def play_all
      ids = []
      @list.items.each { |a| ids += a.tracks.map(&:id) }
      pass_focus(application: "mozart", method: "play_ids", params: ids.join(", "))
    end

    def after_initialize
      @list ||= Spandex::List.new Album.all
      @title = "All albums"
    end

    def after_load
      if params[:artist]
        @list = Spandex::List.new params[:artist].albums
        if params[:genre]
          @title = "#{params[:genre].name} -> #{params[:artist].name}"
        else
          @title = "#{params[:artist].name}"
        end
      else
        @list = Spandex::List.new Album.all
        @title = "All albums"
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
