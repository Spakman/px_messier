# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"

module Messier
  class Messier::GenresCard < Spandex::ListCard
    top_left :back

    def show
      render "<text>Show genres</text>"
    end
  end
end
