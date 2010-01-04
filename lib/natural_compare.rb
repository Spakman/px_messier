# natural_compare.rb
#
# Natural order comparison of two strings
# e.g. "my_prog_v1.1.0" < "my_prog_v1.2.0" < "my_prog_v1.10.0"
# which does not follow alphabetically
#
# Based on Martin Pool's "Natural Order String Comparison" originally written in C
# http://sourcefrog.net/projects/natsort/
#
# This implementation is Copyright (C) 2003 by Alan Davies
# <cs96and_AT_yahoo_DOT_co_DOT_uk>
#
# This software is provided 'as-is', without any express or implied
# warranty.  In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

# Mark Somerville - the only changes I made were very minimal. I removed any
# case-sensitive stuff, changed some formatting and changed the names of some
# variables and the method itself.

# 'Natural order' comparison of two strings
def String.natural_compare(string1, string2)
  string1, string2 = string1.dup, string2.dup
  compareExpression = /^(\D*)(\d*)(.*)$/

  string1.downcase!
  string2.downcase!

  # Remove all whitespace
  string1.gsub!(/\s*/, '')
  string2.gsub!(/\s*/, '')

  while (string1.length > 0) or (string2.length > 0) do
    # Extract non-digits, digits and rest of string
    string1 =~ compareExpression
    chars1, num1, string1 = $1.dup, $2.dup, $3.dup

    string2 =~ compareExpression
    chars2, num2, string2 = $1.dup, $2.dup, $3.dup

    # Compare the non-digits
    case (chars1 <=> chars2)
    # Non-digits are the same, compare the digits...
    when 0
      # If either number begins with a zero, then compare alphabetically,
      # otherwise compare numerically
      if (num1[0] != 48) and (num2[0] != 48)
        num1, num2 = num1.to_i, num2.to_i
      end

      case (num1 <=> num2)
      when -1
        return -1
      when 1 
        return 1
      end
    when -1
      return -1
    when 1
      return 1
    end
  end

  # Strings are naturally equal
  return 0
end
