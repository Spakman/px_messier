# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/artist"

module Messier
  class Messier::AlbumsCard < Spandex::ListCard
    top_left :back

    def after_initialize
      @list ||= Spandex::List.new Album.all
      @title = "Albums"
    end

    def params=(params)
      if params != @params
        @params = params
        if params[:artist]
          @list = Spandex::List.new params[:artist].albums
          if params[:genre]
            @title = "#{params[:genre].name} -> #{params[:artist].name} -> Albums"
          else
            @title = "#{params[:artist].name} -> Albums"
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
