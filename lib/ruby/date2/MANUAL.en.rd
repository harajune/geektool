=begin
= date2 - An alternative date class

== Date

=== Terms and definitions

Some terms and definitions are based on ISO 8601 and JIS X 0301.

==== calendar date

The calendar date is a particular day of a calendar year, identified
by its ordinal number within a calendar month within that year.

==== ordinal date

The ordinal date is a particular day of a calendar year identified by
its ordinal number within the year.

==== week date

The week date is a date identified by calendar week and day numbers.

The calendar week is a seven day period within a calendar year,
starting on a Monday and identified by its ordinal number within the
year; the first calendar week of the year is the one that includes the
first Thursday of that year.  In the Gregorian calendar, this is
equivalent to the week which includes January 4.

==== julian day number

The Julian day number is in elapsed days since noon (Greenwich mean
time) on January 1, 4713 BCE (in the Julian calendar).

In this document, the astronomical Julian day number is same as the
original Julian day number.  And the chronological Julian day number
is a variation of the Julian day number.  Its days begin at midnight
on local time.

In this document, when the term "Julian day number" simply appears, it
just refers to "chronological Julian day number", not the original.

==== modified julian day number

The modified Julian day number is in elapsed days since midnight
(Coordinated universal time) on November 17, 1858 CE (in the Gregorian
calendar).

In this document, the astronomical modified Julian day number is same
as the original modified Julian day number.  And the chronological
modified Julian day number is a variation of the modified Julian day
number.  Its days begin at midnight on local time.

In this document, when the term "modified Julian day number" simply
appears, it just refers to "chronological modified Julian day number",
not the original.

=== Super Class

Object

=== Included Modules

Comparable

=== Class Methods

: civil([year[, mon[, mday[, start]]]])
: new([year[, mon[, mday[, start]]]])
  Creates a date object denoting the given calendar date.

  In this class, BCE years are counted astronomically.
  Thus, the year before the year 1 is the year zero,
  and the year preceding the year zero is the year -1.
  The month and the day of month should be a negative or a positive number
  (reverse order when negative).
  They should not be zero.

  The last argument should be a Julian day number
  which denotes the first day of the Gregorian calendar.
  You can also give Date::GREGORIAN which mean
  the proleptic Gregorian calendar,
  and Date::JULIAN which mean the proleptic Julian calendar.
  Default is Date::ITALY (October 15, 1582).

  See also jd.

: commercial([cwyear[, cweek[, cwday[, start]]]])
  Creates a date object denoting the given week date.

  The week and the day of week should be a negative or a positive number
  (reverse order when negative).
  They should not be zero.

  This method does not accept dates before the day of calendar reform.

  See also jd and new.

: jd([jd[, start]])
  Creates a date object denoting the given Julian day number.

  In this class, some important methods do not accept
  negative Julian day numbers.

  See also new.

: nth_kday([year[, mon[, n[, k[, start]]]]])
  Returns a date object denoting
  the given Nth (-5 to 5, except zero) Kday (0-6)
  in the given month of year.

: ordinal([year[, yday[, start]]])
  Creates a date object denoting the given ordinal date.

  The day of year should be a negative or a positive number
  (reverse order when negative).
  It should not be zero.

  See also jd and new.

: parse([str[, complete[, start]]])
  Parses the given representation of dates and times,
  and creates a date object.

  If the optional second argument is true and
  the detected year is in the range "00" to "99",
  considers the year a 2-digit form and makes it full.
  Default is false.

  _parse is also available.
  This method is similar to parse,
  but returns a hash which contain detected elements,
  not creates a date object.

: strptime([str[, format[, start]]])
  Parses the given representation of dates and times
  with the given template, and creates a date object.

  For example, the following formats are acceptable:

    %Y-%m-%d
    %Y-%j
    %G-W%V-%u
    %s
    %Q

  _strptime is also available.
  This method is similar to strptime,
  but returns a hash which contain detected elements,
  not creates a date object.

  See also strptime(3) and strftime.

: today([start])
  Creates a date object denoting the present day.

: valid_civil? (year, mon, mday[, start])
: valid_date? (year, mon, mday[, start])
  Returns true if the given calendar date is valid,
  and false if not.

  See also jd and civil.

: valid_commercial? (cwyear, cweek, cwday[, start])
  Returns true if the given week date is valid,
  and false if not.

  See also jd and commercial.

: valid_jd? (jd[, start])
  Just returns true.

  It's nonsense, but is for symmetry.

  See also jd.

: valid_ordinal? (year, yday[, start])
  Returns true if the given ordinal date is valid,
  and false if not.

  See also jd and ordinal.

=== Methods

: self + n
  Returns a date object pointing n days after self.
  The n should be a numeric value.

: self - x
  Returns the difference between the two dates if the x is a date object.
  If the x is a numeric value, it returns
  a date object pointing x days before self.

: self << n
  Returns a date object pointing n months before self.
  The n should be a numeric value.

: self <=> other
  Compares the two dates and returns -1, zero or 1.
  The other should be a date object or
  a numeric value as an astronomical Julian day number.

: self === other
  Returns true if they are the same day.

: self >> n
  Returns a date object pointing n months after self.
  The n should be a numeric value.

: asctime
: ctime
  Returns a string in asctime(3) format (but without "\n\0" at the end).

: cwday
  Returns the day of calendar week (1-7, Monday is 1).

: cweek
  Returns the calendar week number (1-53).

: cwyear
  Returns the calendar week based year.

: downto(min){|date| ...}
  This method is equivalent to (({step(min, -1){|date| ...}})).

: england
  This method is equivalent to (({new_start(Date::ENGLAND)})).

: gregorian
  This method is equivalent to (({new_start(Date::GREGORIAN)})).

: iso8601
: rfc3339
  Returns a string in an ISO 8601 format
  (This method doesn't use the expanded representations).

: italy
  This method is equivalent to (({new_start(Date::ITALY)})).

: jd
  Returns the Julian day number.
  It has no time of the day.

  ajd is also available.
  This method is similar to jd,
  but returns the astronomical Julian day number.
  It may have time of the day.

: jisx0301
  Returns a string in a JIX X 0301 format.
  However this returns an ISO 8601 format if before Meiji era.
  Anyhow this do not use luni-solar calendar even if Meiji 6.

: julian
  This method is equivalent to (({new_start(Date::JULIAN)})).

: leap?
  Returns true if the year is a leap year.

: mday
: day
  Returns the day of month (1-31).

: mjd
  Returns the modified Julian day number.
  It has no time of the day.

  amjd is also available.
  This method is similar to mjd,
  but returns the astronomical modified Julian day number.
  It may have time of the day.

: mon
: month
  Returns the month (1-12).

: new_start([start])
  Duplicates self and resets the its first day of the Gregorian calendar.
  Default is Date::ITALY (October 15, 1582).

  See also new.

: next_day([n])
  Returns a date object denoting the following day.

: next_month([n])
  Returns a date object denoting the following month.

: next_year([n])
  Returns a date object denoting the following year.

: nth_kday?(n, k)
  Returns true if the day is an Nth (-5 to 5, except zero) Kday (0-6).

: prev_day([n])
  Returns a date object denoting the previous day.

: prev_month([n])
  Returns a date object denoting the previous month.

: prev_year([n])
  Returns a date object denoting the previous year.

: rfc2822
: rfc822
  Returns a string in an RFC 2822 format.

: start
  Returns a Julian day number
  denoting the first day of the Gregorian calendar.

  See also new.

: step(limit[, step]){|date| ...}
  Iterates evaluation of the given block, which takes a date object.
  The limit should be a date object, and the step should be a nonzero value.

: strftime([format])
  Formats the date with the given template.
  The following conversion specifications are supported:

  %A, %a, %B, %b, %C, %c, %D, %d, %e, %F, %G, %g, %H, %h, %I, %j, %k,
  %L, %l, %M, %m, %N, %n, %P, %p, %Q, %R, %r, %S, %s, %T, %t, %U, %u,
  %V, %v, %W, %w, %X, %x, %Y, %y, %Z, %z, %%, %+

  See also strftime(3) and strptime.

: succ
: next
  Returns a date object denoting the following day.

: to_s
  Returns a string in an ISO 8601 format
  (This method doesn't use the expanded representations).

: upto(max){|date| ...}
  This method is equivalent to (({step(max, 1){|date| ...}})).

: wday
  Returns the day of week (0-6, Sunday is zero).

: yday
  Returns the day of year (1-366).

: year
  Returns the year.


== DateTime

=== Super Class

Date

=== Class Methods

: civil([year[, mon[, mday[, hour[, min[, sec[, offset[, start]]]]]]]])
: new([year[, mon[, mday[, hour[, min[, sec[, offset[, start]]]]]]]])
  Creates a date-time object denoting the given calendar date.

: commercial([cwyear[, cweek[, cwday[, hour[, min[, sec[, offset[, start]]]]]]]])
  Creates a date-time object denoting the given week date.

: jd([jd[, hour[, min[, sec[, offset[, start]]]]]])
  Creates a date-time object denoting
  the given Julian day number.

: now([start])
  Creates a date-time object denoting the present time.

: nth_kday([year[, mon[, n[, k, [, hour[, min[, sec[, offset[, start]]]]]]]]])
  Returns a date object denoting
  the given Nth (-5 to 5, except zero) Kday (0-6)
  in the given month of year.

: ordinal([year[, yday[, hour[, min[, sec[, offset[, start]]]]]]])
  Creates a date-time object denoting the given ordinal date.

=== Methods

: hour
  Returns the hour (0-23).

: iso8601([n])
: rfc3339([n])
  Returns a string in an ISO 8601 format.

: jisx0301([n])
  Returns a string in a JIX X 0301 format.

: min
  Returns the minute (0-59).

: new_offset([offset])
  Duplicates self and resets the its offset.
  Default is zero (UTC).

  See also new.

: offset
  Returns the offset.

: sec
  Returns the second (0-59).

: zone
  Returns the timezone.


= date/holiday - determination of secular and religious holidays

== Date

=== Class Methods

: gregorian_easter(year[, start])
: easter(year[, start])
  Returns a date object denoting
  the Easter sunday in the given Gregorian year.

: julian_easter(year[, start])
  Returns a date object denoting
  the Easter sunday in the given Julian year.

=== Methods

: easter?
  Returns true if the day is an Easter sunday.

: national_holiday?
  Returns true if the day is a Japanese national holiday.

: old_national_holiday?
  Returns true if the day is an old Japanese national holiday.
  This is still experimental.


= parsedate - date and time parsing

== ParseDate

=== Module Functions

: parsedate(str[, complete])
  Parses the given representation of dates and times,
  and returns an array which contain detected elements
  (year, month, day of month, hour, minute, second, timezone and day of week).

  If the optional second argument is true and
  the detected year is in the range 00 to 99,
  considers the year a 2-digit form and makes it full.
  Default is false.

  parsedate can handle various formats.
  For example, the following representaions are acceptable:

    Sat
    Saturday
    1999-08-28
    21:45:09
    09:45:09 PM
    1999-08-28T21:45:09+0900
    19990828 214509
    H11.08.28T21:45:09Z
    Sat Aug 28 21:45:09 1999
    Sat Aug 28 21:45:09 JST 1999
    Sat, 28 Aug 1999 21:45:09 -0400
    Saturday, 28-Aug-99 21:45:09 GMT
    08/28/1999
    1999/08/28

  See also Date::parse.
=end
