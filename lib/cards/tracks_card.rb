# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"
require_relative "../models/track"

module Messier
  class Messier::TracksCard < Spandex::ListCard
    top_left :back
    jog_wheel_button :method => :play

    def play
      ids = @list.selected_to_end.map(&:id)
      pass_focus(application: "mozart", method: "play_ids", params: ids.join(", "))
    end

    def after_initialize
      @list ||= Spandex::List.new Track.all
      @title = "Tracks"
    end

    def params=(params)
      if params != @params
        @params = params
        if params[:album]
          @list = Spandex::List.new params[:album].tracks
          if params[:genre]
            @title = "#{params[:genre]} -> #{params[:artist]} -> #{params[:album].name} -> Tracks"
          else
            @title = "#{params[:artist]} -> #{params[:album].name} -> Tracks"
          end
        else
          @list = Spandex::List.new Track.all
          @title = "Tracks"
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
