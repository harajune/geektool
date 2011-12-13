# parsedate.rb: Written by Tadayoshi Funaba 2001-2003
# $Id: parsedate.rb,v 2.7 2003-08-12 05:09:41+09 tadf Exp $

require 'date/format'

module ParseDate

  def parsedate(str, comp=false)
    Date._parse(str, comp).
      values_at(:year, :mon, :mday, :hour, :min, :sec, :zone, :wday)
  end

  module_function :parsedate

end
