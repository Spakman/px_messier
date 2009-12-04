# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"

module Messier
  class Messier::MenuCard < Spandex::ListCard
    top_left :back

    def after_initialize
      @list ||= Spandex::List.new %w( Artists Genres Playlists )
    end

    def show
      render "<button position=\"top_left\">Back</button><title>Mark's music</title>#{@list}"
    end
  end
end
