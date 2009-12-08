# Copyright (C) 2009 Mark Somerville <mark@scottishclimbs.com>
# Released under the General Public License (GPL) version 3.
# See COPYING

require "spandex/card"
require "spandex/list"

module Messier
  class Messier::ArtistsCard < Spandex::ListCard
    top_left :back

    def show
      render "<text>Show artists</text>"
    end
  end
end
