# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/artist"
require_relative "tracks_card"

module Messier
  class Messier::AlbumsCard < Spandex::ListCard
    top_left :back

    jog_wheel_button card: Messier::TracksCard, params: -> do
      if @params and @params[:genre]
        { genre: @params[:genre], artist: @params[:artist], album: @list.selected }
      else
        { album: @list.selected, artist: @params[:artist] }
      end
    end

    def after_initialize
      @list ||= Spandex::List.new Album.all
      @title = "All albums"
    end

    def params=(params)
      if params != @params
        @params = params
        if params[:artist]
          @list = Spandex::List.new params[:artist].albums
          if params[:genre]
            @title = "#{params[:genre].name} -> #{params[:artist].name}"
          else
            @title = "#{params[:artist].name}"
          end
        else
          @list = Spandex::List.new Album.all
          @title = "Albums"
        end
      end
    end

    def show
      render %{
        <title>#{@title}</title>
        <button position="top_left">Back</button>
        #{@list}
      }
    end
  end
end
