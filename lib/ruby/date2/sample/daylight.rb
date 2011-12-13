#! /usr/bin/env ruby

# daylight.rb: Written by Tadayoshi Funaba 1998-2002,2006,2007
# $Id: daylight.rb,v 2.6 2007-04-07 08:28:51+09 tadf Exp $

require 'date'

year = Date.today.year
[[ 3, 2, 0, 'US Daylight Saving Time begins'], # second Sunday in March
 [11, 1, 0, 'US Daylight Saving Time ends']].  # first Sunday in November
each do |mon, n, k, event|
  puts(Date.nth_kday(year, mon, n, k).to_s + '  ' + event)
end
