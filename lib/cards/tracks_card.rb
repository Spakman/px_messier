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
    bottom_right :method => :queue_track
    bottom_left :method => :queue_all_tracks

    def play
      ids = @list.selected_to_end.map(&:id)
      pass_focus(application: "mozart", method: "play_ids", params: ids.join(", "))
    end

    def queue_track
      pass_focus application: "mozart", method: "queue_ids", params: @list.selected.id
    end

    def queue_all_tracks
      ids = @list.items.map(&:id)
      pass_focus(application: "mozart", method: "queue_ids", params: ids.join(", "))
    end

    def after_initialize
      @list ||= Spandex::List.new Track.all
      @title = "All tracks"
    end

    def after_load
      if params[:album]
        @list = Spandex::List.new params[:album].tracks
        if params[:genre]
          @title = "#{params[:genre]} -> .. -> #{params[:album].name}"
        else
          @title = "#{params[:artist]} -> #{params[:album].name}"
        end
      else
        @list = Spandex::List.new Track.all
        @title = "All tracks"
      end
    end

    def show
      render %{
        <title>#{@title}</title>
        <button position="top_left">Back</button>
        <button position="bottom_left">Queue all</button>
        <button position="bottom_right">Queue track</button>
        #{@list}
      }
    end
  end
end
