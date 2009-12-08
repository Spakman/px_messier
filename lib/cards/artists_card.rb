# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/artist"

module Messier
  class Messier::ArtistsCard < Spandex::ListCard
    top_left :back

    def after_initialize
      @list ||= Spandex::List.new Artist.all
      @title = "Artists"
    end

    def params=(params)
      if params != @params
        @params = params
        if params[:genre]
          @list = Spandex::List.new params[:genre].artists
          @title = "#{params[:genre].name} -> Artists"
        else
          @list = Spandex::List.new Artist.all
          @title = "Artists"
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
