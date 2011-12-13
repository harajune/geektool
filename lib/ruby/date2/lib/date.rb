# date.rb: Written by Tadayoshi Funaba 1998-2009
# $Id: date.rb,v 2.41 2010-01-09 09:05:59+09 tadf Exp $

require 'rational' unless defined?(Rational)
require 'date/format'

class Date

  include Comparable

  MONTHNAMES = [nil] + %w(January February March April May June July
                         August September October November December)

  DAYNAMES = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)

  ABBR_MONTHNAMES = [nil] + %w(Jan Feb Mar Apr May Jun
                              Jul Aug Sep Oct Nov Dec)

  ABBR_DAYNAMES = %w(Sun Mon Tue Wed Thu Fri Sat)


  [MONTHNAMES, DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYNAMES].each do |xs|
    xs.each{|x| x.freeze unless x.nil?}.freeze
  end

  class Infinity < Numeric

    include Comparable

    def initialize(d=1) @d = d <=> 0 end

    def d() @d end

    protected :d

    def zero? () false end
    def finite? () false end
    def infinite? () d.nonzero? end
    def nan? () d.zero? end

    def abs() self.class.new end

    def -@ () self.class.new(-d) end
    def +@ () self.class.new(+d) end

    def <=> (other)
      case other
      when Infinity; return d <=> other.d
      when Numeric; return d
      else
	begin
	  l, r = other.coerce(self)
	  return l <=> r
	rescue NoMethodError
	end
      end
      nil
    end

    def coerce(other)
      case other
      when Numeric; return -d, d
      else
	super
      end
    end

  end

  ITALY     = 2299161 # 1582-10-15
  ENGLAND   = 2361222 # 1752-09-14
  JULIAN    =  Infinity.new
  GREGORIAN = -Infinity.new

  HALF_DAYS_IN_DAY       = Rational(1, 2)
  HOURS_IN_DAY           = Rational(1, 24)
  MINUTES_IN_DAY         = Rational(1, 1440)
  SECONDS_IN_DAY         = Rational(1, 86400)
  MILLISECONDS_IN_DAY    = Rational(1, 86400*10**3)
  NANOSECONDS_IN_DAY     = Rational(1, 86400*10**9)
  MILLISECONDS_IN_SECOND = Rational(1, 10**3)
  NANOSECONDS_IN_SECOND  = Rational(1, 10**9)

  MJD_EPOCH_IN_AJD       = Rational(4800001, 2) # 1858-11-17
  UNIX_EPOCH_IN_AJD      = Rational(4881175, 2) # 1970-01-01
  MJD_EPOCH_IN_CJD       = 2400001
  UNIX_EPOCH_IN_CJD      = 2440588
  LD_EPOCH_IN_CJD        = 2299160

  t = Module.new do

    private

    def find_fdoy(y, sg)
      j = nil
      1.upto(31) do |d|
	break if j = _valid_civil?(y, 1, d, sg)
      end
      j
    end

    def find_ldoy(y, sg)
      j = nil
      31.downto(1) do |d|
	break if j = _valid_civil?(y, 12, d, sg)
      end
      j
    end

    def find_fdom(y, m, sg)
      j = nil
      1.upto(31) do |d|
	break if j = _valid_civil?(y, m, d, sg)
      end
      j
    end

    def find_ldom(y, m, sg)
      j = nil
      31.downto(1) do |d|
	break if j = _valid_civil?(y, m, d, sg)
      end
      j
    end

    def ordinal_to_jd(y, d, sg=GREGORIAN)
      find_fdoy(y, sg) + d - 1
    end

    def jd_to_ordinal(jd, sg=GREGORIAN)
      y = jd_to_civil(jd, sg)[0]
      j = find_fdoy(y, sg)
      doy = jd - j + 1
      return y, doy
    end

    def civil_to_jd(y, m, d, sg=GREGORIAN)
      if m <= 2
	y -= 1
	m += 12
      end
      a = (y / 100.0).floor
      b = 2 - a + (a / 4.0).floor
      jd = (365.25 * (y + 4716)).floor +
	(30.6001 * (m + 1)).floor +
	d + b - 1524
      if jd < sg
	jd -= b
      end
      jd
    end

    def jd_to_civil(jd, sg=GREGORIAN)
      if jd < sg
	a = jd
      else
	x = ((jd - 1867216.25) / 36524.25).floor
	a = jd + 1 + x - (x / 4.0).floor
      end
      b = a + 1524
      c = ((b - 122.1) / 365.25).floor
      d = (365.25 * c).floor
      e = ((b - d) / 30.6001).floor
      dom = b - d - (30.6001 * e).floor
      if e <= 13
	m = e - 1
	y = c - 4716
      else
	m = e - 13
	y = c - 4715
      end
      return y, m, dom
    end

    def commercial_to_jd(y, w, d, sg=GREGORIAN)
      j = find_fdoy(y, sg) + 3
      (j - (((j - 1) + 1) % 7)) +
	7 * (w - 1) +
	(d - 1)
    end

    def jd_to_commercial(jd, sg=GREGORIAN)
      a = jd_to_civil(jd - 3, sg)[0]
      y = if jd >= commercial_to_jd(a + 1, 1, 1, sg) then a + 1 else a end
      w = 1 + ((jd - commercial_to_jd(y, 1, 1, sg)) / 7).floor
      d = (jd + 1) % 7
      d = 7 if d == 0
      return y, w, d
    end

    def weeknum_to_jd(y, w, d, f=0, sg=GREGORIAN)
      a = find_fdoy(y, sg) + 6
      (a - ((a - f) + 1) % 7 - 7) + 7 * w + d
    end

    def jd_to_weeknum(jd, f=0, sg=GREGORIAN)
      y, m, d = jd_to_civil(jd, sg)
      a = find_fdoy(y, sg) + 6
      w, d = (jd - (a - ((a - f) + 1) % 7) + 7).divmod(7)
      return y, w, d
    end

    def nth_kday_to_jd(y, m, n, k, sg=GREGORIAN)
      j = if n > 0
	    find_fdom(y, m, sg) - 1
	  else
	    find_ldom(y, m, sg) + 7
	  end
      (j - (((j - k) + 1) % 7)) + 7 * n
    end

    def jd_to_nth_kday(jd, sg=GREGORIAN)
      y, m, d = jd_to_civil(jd, sg)
      j = find_fdom(y, m, sg)
      return y, m, ((jd - j) / 7).floor + 1, jd_to_wday(jd)
    end

    def ajd_to_jd(ajd, of=0) (ajd + of + HALF_DAYS_IN_DAY).divmod(1) end
    def jd_to_ajd(jd, fr, of=0) jd + fr - of - HALF_DAYS_IN_DAY end

    def day_fraction_to_time(fr)
      ss,  fr = fr.divmod(SECONDS_IN_DAY) # 4p
      h,   ss = ss.divmod(3600)
      min, s  = ss.divmod(60)
      return h, min, s, fr * 86400
    end

    begin
      Rational(Rational(1, 2), 2) # a challenge

      def time_to_day_fraction(h, min, s)
	Rational(h * 3600 + min * 60 + s, 86400) # 4p
      end
    rescue
      def time_to_day_fraction(h, min, s)
	if Integer === h && Integer === min && Integer === s
	  Rational(h * 3600 + min * 60 + s, 86400) # 4p
	else
	  (h * 3600 + min * 60 + s).to_r/86400 # 4p
	end
      end
    end

    def amjd_to_ajd(amjd) amjd + MJD_EPOCH_IN_AJD end
    def ajd_to_amjd(ajd) ajd - MJD_EPOCH_IN_AJD end
    def mjd_to_jd(mjd) mjd + MJD_EPOCH_IN_CJD end
    def jd_to_mjd(jd) jd - MJD_EPOCH_IN_CJD end
    def ld_to_jd(ld) ld + LD_EPOCH_IN_CJD end
    def jd_to_ld(jd) jd - LD_EPOCH_IN_CJD end

    def jd_to_wday(jd) (jd + 1) % 7 end

    def _valid_jd? (jd, sg=GREGORIAN) jd end

    def _valid_ordinal? (y, d, sg=GREGORIAN)
      if d < 0
	j = find_ldoy(y, sg)
	ny, nd = jd_to_ordinal(j + d + 1, sg)
	return unless ny == y
	d = nd
      end
      jd = ordinal_to_jd(y, d, sg)
      return unless [y, d] == jd_to_ordinal(jd, sg)
      jd
    end

    def _valid_civil? (y, m, d, sg=GREGORIAN)
      if m < 0
	m += 13
      end
      if d < 0
	j = find_ldom(y, m, sg)
	ny, nm, nd = jd_to_civil(j + d + 1, sg)
	return unless [ny, nm] == [y, m]
	d = nd
      end
      jd = civil_to_jd(y, m, d, sg)
      return unless [y, m, d] == jd_to_civil(jd, sg)
      jd
    end

    def _valid_commercial? (y, w, d, sg=GREGORIAN)
      if d < 0
	d += 8
      end
      if w < 0
	ny, nw, nd =
	  jd_to_commercial(commercial_to_jd(y + 1, 1, 1, sg) + w * 7, sg)
	return unless ny == y
	w = nw
      end
      jd = commercial_to_jd(y, w, d, sg)
      return unless [y, w, d] == jd_to_commercial(jd, sg)
      jd
    end

    def _valid_weeknum? (y, w, d, f, sg=GREGORIAN)
      if d < 0
	d += 7
      end
      if w < 0
	ny, nw, nd, nf =
	  jd_to_weeknum(weeknum_to_jd(y + 1, 1, f, f, sg) + w * 7, f, sg)
	return unless ny == y
	w = nw
      end
      jd = weeknum_to_jd(y, w, d, f, sg)
      return unless [y, w, d] == jd_to_weeknum(jd, f, sg)
      jd
    end

    def _valid_nth_kday? (y, m, n, k, sg=GREGORIAN)
      if k < 0
	k += 7
      end
      if n < 0
	ny, nm = (y * 12 + m).divmod(12)
	nm,    = (nm + 1)    .divmod(1)
	ny, nm, nn, nk =
	  jd_to_nth_kday(nth_kday_to_jd(ny, nm, 1, k, sg) + n * 7, sg)
	return unless [ny, nm] == [y, m]
	n = nn
      end
      jd = nth_kday_to_jd(y, m, n, k, sg)
      return unless [y, m, n, k] == jd_to_nth_kday(jd, sg)
      jd
    end

    def _valid_time? (h, min, s)
      h   += 24 if h   < 0
      min += 60 if min < 0
      s   += 60 if s   < 0
      return unless ((0...24) === h &&
		     (0...60) === min &&
		     (0...60) === s) ||
		     (24 == h &&
		       0 == min &&
		       0 == s)
      time_to_day_fraction(h, min, s)
    end

  end

  extend  t
  include t

  def self.julian_leap? (y) y % 4 == 0 end
  def self.gregorian_leap? (y) y % 4 == 0 && y % 100 != 0 || y % 400 == 0 end

  class << self; alias_method :leap?, :gregorian_leap? end
  class << self; alias_method :new!, :new end

  def self.valid_jd? (jd, sg=ITALY)
    !!_valid_jd?(jd, sg)
  end

  def self.valid_ordinal? (y, d, sg=ITALY)
    !!_valid_ordinal?(y, d, sg)
  end

  def self.valid_civil? (y, m, d, sg=ITALY)
    !!_valid_civil?(y, m, d, sg)
  end

  class << self; alias_method :valid_date?, :valid_civil? end

  def self.valid_commercial? (y, w, d, sg=ITALY)
    !!_valid_commercial?(y, w, d, sg)
  end

  def self.valid_weeknum? (y, w, d, f, sg=ITALY)
    !!_valid_weeknum?(y, w, d, f, sg)
  end

  private_class_method :valid_weeknum?

  def self.valid_nth_kday? (y, m, n, k, sg=ITALY)
    !!_valid_nth_kday?(y, m, n, k, sg)
  end

#  private_class_method :valid_nth_kday?

  def self.valid_time? (h, min, s)
    !!_valid_time?(h, min, s)
  end

  private_class_method :valid_time?

  def self.jd(jd=0, sg=ITALY)
    jd = _valid_jd?(jd, sg)
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  def self.ordinal(y=-4712, d=1, sg=ITALY)
    unless jd = _valid_ordinal?(y, d, sg)
      raise ArgumentError, 'invalid date'
    end
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  def self.civil(y=-4712, m=1, d=1, sg=ITALY)
    unless jd = _valid_civil?(y, m, d, sg)
      raise ArgumentError, 'invalid date'
    end
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  class << self; alias_method :new, :civil end

  def self.commercial(y=-4712, w=1, d=1, sg=ITALY)
    unless jd = _valid_commercial?(y, w, d, sg)
      raise ArgumentError, 'invalid date'
    end
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  def self.weeknum(y=-4712, w=0, d=1, f=0, sg=ITALY)
    unless jd = _valid_weeknum?(y, w, d, f, sg)
      raise ArgumentError, 'invalid date'
    end
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  private_class_method :weeknum

  def self.nth_kday(y=-4712, m=1, n=1, k=1, sg=ITALY)
    unless jd = _valid_nth_kday?(y, m, n, k, sg)
      raise ArgumentError, 'invalid date'
    end
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

#  private_class_method :nth_kday

  def self.rewrite_frags(elem)
    elem ||= {}
    if seconds = elem[:seconds]
      d,   fr = seconds.divmod(86400)
      h,   fr = fr.divmod(3600)
      min, fr = fr.divmod(60)
      s,   fr = fr.divmod(1)
      elem[:jd] = UNIX_EPOCH_IN_CJD + d
      elem[:hour] = h
      elem[:min] = min
      elem[:sec] = s
      elem[:sec_fraction] = fr
      elem.delete(:seconds)
      elem.delete(:offset)
    end
    elem
  end

  private_class_method :rewrite_frags

  def self.complete_frags(elem)
    i = 0
    g = [[:time, [:hour, :min, :sec]],
	 [nil, [:jd]],
	 [:ordinal, [:year, :yday, :hour, :min, :sec]],
	 [:civil, [:year, :mon, :mday, :hour, :min, :sec]],
	 [:commercial, [:cwyear, :cweek, :cwday, :hour, :min, :sec]],
	 [:wday, [:wday, :hour, :min, :sec]],
	 [:wnum0, [:year, :wnum0, :wday, :hour, :min, :sec]],
	 [:wnum1, [:year, :wnum1, :wday, :hour, :min, :sec]],
	 [nil, [:cwyear, :cweek, :wday, :hour, :min, :sec]],
	 [nil, [:year, :wnum0, :cwday, :hour, :min, :sec]],
	 [nil, [:year, :wnum1, :cwday, :hour, :min, :sec]]].
      collect{|k, a| e = elem.values_at(*a).compact; [k, a, e]}.
      select{|k, a, e| e.size > 0}.
      sort_by{|k, a, e| [e.size, i -= 1]}.last

    d = nil

    if g && g[0] && (g[1].size - g[2].size) != 0
      d ||= Date.today

      case g[0]
      when :ordinal
	elem[:year] ||= d.year
	elem[:yday] ||= 1
      when :civil
	g[1].each do |e|
	  break if elem[e]
	  elem[e] = d.__send__(e)
	end
	elem[:mon]  ||= 1
	elem[:mday] ||= 1
      when :commercial
	g[1].each do |e|
	  break if elem[e]
	  elem[e] = d.__send__(e)
	end
	elem[:cweek] ||= 1
	elem[:cwday] ||= 1
      when :wday
	elem[:jd] ||= (d - d.wday + elem[:wday]).jd
      when :wnum0
	g[1].each do |e|
	  break if elem[e]
	  elem[e] = d.__send__(e)
	end
	elem[:wnum0] ||= 0
	elem[:wday]  ||= 0
      when :wnum1
	g[1].each do |e|
	  break if elem[e]
	  elem[e] = d.__send__(e)
	end
	elem[:wnum1] ||= 0
	elem[:wday]  ||= 1
      end
    end

    if g && g[0] == :time
      if self <= DateTime
	d ||= Date.today
	elem[:jd] ||= d.jd
      end
    end

    elem[:hour] ||= 0
    elem[:min]  ||= 0
    elem[:sec]  ||= 0
    elem[:sec] = [elem[:sec], 59].min

    elem
  end

  private_class_method :complete_frags

  def self.valid_date_frags?(elem, sg)
    catch :jd do
      a = elem.values_at(:jd)
      if a.all?
	if jd = _valid_jd?(*(a << sg))
	  throw :jd, jd
	end
      end

      a = elem.values_at(:year, :yday)
      if a.all?
	if jd = _valid_ordinal?(*(a << sg))
	  throw :jd, jd
	end
      end

      a = elem.values_at(:year, :mon, :mday)
      if a.all?
	if jd = _valid_civil?(*(a << sg))
	  throw :jd, jd
	end
      end

      a = elem.values_at(:cwyear, :cweek, :cwday)
      if a[2].nil? && elem[:wday]
	a[2] = elem[:wday].nonzero? || 7
      end
      if a.all?
	if jd = _valid_commercial?(*(a << sg))
	  throw :jd, jd
	end
      end

      a = elem.values_at(:year, :wnum0, :wday)
      if a[2].nil? && elem[:cwday]
	a[2] = elem[:cwday] % 7
      end
      if a.all?
	if jd = _valid_weeknum?(*(a << 0 << sg))
	  throw :jd, jd
	end
      end

      a = elem.values_at(:year, :wnum1, :wday)
      if a[2]
	a[2] = (a[2] - 1) % 7
      end
      if a[2].nil? && elem[:cwday]
	a[2] = (elem[:cwday] - 1) % 7
      end
      if a.all?
	if jd = _valid_weeknum?(*(a << 1 << sg))
	  throw :jd, jd
	end
      end
    end
  end

  private_class_method :valid_date_frags?

  def self.valid_time_frags? (elem)
    h, min, s = elem.values_at(:hour, :min, :sec)
    _valid_time?(h, min, s)
  end

  private_class_method :valid_time_frags?

  def self.new_by_frags(elem, sg)
    elem = rewrite_frags(elem)
    elem = complete_frags(elem)
    unless jd = valid_date_frags?(elem, sg)
      raise ArgumentError, 'invalid date'
    end
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  private_class_method :new_by_frags

  def self.strptime(str='-4712-01-01', fmt='%F', sg=ITALY)
    elem = _strptime(str, fmt)
    new_by_frags(elem, sg)
  end

  def self.parse(str='-4712-01-01', comp=false, sg=ITALY)
    elem = _parse(str, comp)
    new_by_frags(elem, sg)
  end

  class << self

    def once(*ids)
      for id in ids
	module_eval <<-"end;"
	  alias_method :__#{id.object_id}__, :#{id.to_s}
	  private :__#{id.object_id}__
	  def #{id.to_s}(*args, &block)
	    (@__#{id.object_id}__ ||= [__#{id.object_id}__(*args, &block)])[0]
	  end
	end;
      end
    end

    private :once

  end

  def initialize(ajd=0, of=0, sg=ITALY) @ajd, @of, @sg = ajd, of, sg end

  def ajd() @ajd end
  def amjd() ajd_to_amjd(@ajd) end

  once :amjd

  def jd() ajd_to_jd(@ajd, @of)[0] end
  def day_fraction() ajd_to_jd(@ajd, @of)[1] end
  def mjd() jd_to_mjd(jd) end
  def ld() jd_to_ld(jd) end

  once :jd, :day_fraction, :mjd, :ld

  def civil() jd_to_civil(jd, @sg) end
  def ordinal() jd_to_ordinal(jd, @sg) end
  def commercial() jd_to_commercial(jd, @sg) end
  def weeknum0() jd_to_weeknum(jd, 0, @sg) end
  def weeknum1() jd_to_weeknum(jd, 1, @sg) end

  once :civil, :ordinal, :commercial, :weeknum0, :weeknum1
  private :civil, :ordinal, :commercial, :weeknum0, :weeknum1

  def year() civil[0] end
  def yday() ordinal[1] end
  def mon() civil[1] end
  def mday() civil[2] end

  alias_method :month, :mon
  alias_method :day, :mday

  def wnum0() weeknum0[1] end
  def wnum1() weeknum1[1] end

  private :wnum0, :wnum1

  def time() day_fraction_to_time(day_fraction) end

  once :time
  private :time

  def hour() time[0] end
  def min() time[1] end
  def sec() time[2] end
  def sec_fraction() time[3] end

  alias_method :minute, :min
  alias_method :second, :sec
  alias_method :second_fraction, :sec_fraction

  private :hour, :min, :sec, :sec_fraction,
	  :minute, :second, :second_fraction

  def zone() strftime('%:z') end

  private :zone

  def cwyear() commercial[0] end
  def cweek() commercial[1] end
  def cwday() commercial[2] end

  def wday() jd_to_wday(jd) end

  once :wday

=begin
  MONTHNAMES.each_with_index do |n, i|
    if n
      define_method(n.downcase + '?'){mon == i}
    end
  end
=end

  DAYNAMES.each_with_index do |n, i|
    define_method(n.downcase + '?'){wday == i}
  end

  def nth_kday? (n, k)
    k == wday && jd === nth_kday_to_jd(year, mon, n, k, start)
  end

#  private :nth_kday?

  def julian? () jd < @sg end
  def gregorian? () !julian? end

  once :julian?, :gregorian?

  def fix_style
    if julian?
    then self.class::JULIAN
    else self.class::GREGORIAN end
  end

  private :fix_style

  def leap?
    jd_to_civil(civil_to_jd(year, 3, 1, fix_style) - 1,
		fix_style)[-1] == 29
  end

  once :leap?

  def start() @sg end
  def new_start(sg=self.class::ITALY) self.class.new!(@ajd, @of, sg) end

  def italy() new_start(self.class::ITALY) end
  def england() new_start(self.class::ENGLAND) end
  def julian() new_start(self.class::JULIAN) end
  def gregorian() new_start(self.class::GREGORIAN) end

  def offset() @of end

  def new_offset(of=0)
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    self.class.new!(@ajd, of, @sg)
  end

  private :offset, :new_offset

  def + (n)
    case n
    when Numeric; return self.class.new!(@ajd + n, @of, @sg)
    end
    raise TypeError, 'expected numeric'
  end

  def - (x)
    case x
    when Numeric; return self.class.new!(@ajd - x, @of, @sg)
    when Date;    return @ajd - x.ajd
    end
    raise TypeError, 'expected numeric or date'
  end

  def <=> (other)
    case other
    when Numeric; return @ajd <=> other
    when Date;    return @ajd <=> other.ajd
    end
    nil
  end

  def === (other)
    case other
    when Numeric; return jd == other
    when Date;    return jd == other.jd
    end
    false
  end

  def next_day(n=1) self + n end
  def prev_day(n=1) self - n end

  def next() next_day end

  alias_method :succ, :next

  def >> (n)
    y, m = (year * 12 + (mon - 1) + n).divmod(12)
    m,   = (m + 1)                    .divmod(1)
    d = mday
    d -= 1 until jd2 = _valid_civil?(y, m, d, @sg)
    self + (jd2 - jd)
  end

  def << (n) self >> -n end

  def next_month(n=1) self >> n end
  def prev_month(n=1) self << n end

  def next_year(n=1) self >> n * 12 end
  def prev_year(n=1) self << n * 12 end

  require 'enumerator'

  def step(limit, step=1)
=begin
    if step.zero?
      raise ArgumentError, "step can't be 0"
    end
=end
    unless block_given?
      return to_enum(:step, limit, step)
    end
    da = self
    op = %w(- <= >=)[step <=> 0]
    while da.__send__(op, limit)
      yield da
      da += step
    end
    self
  end

  def upto  (max, &block) step(max, +1, &block) end
  def downto(min, &block) step(min, -1, &block) end

  def eql? (other) Date === other && self == other end
  def hash() @ajd.hash end

  def inspect
    format('#<%s: %s (%s,%s,%s)>', self.class, to_s, @ajd, @of, @sg)
  end

  def to_s() format('%.4d-%02d-%02d', year, mon, mday) end # 4p

  def marshal_dump() [@ajd, @of, @sg] end
  def marshal_load(a) @ajd, @of, @sg, = a end

end

class DateTime < Date

  def self.jd(jd=0, h=0, min=0, s=0, of=0, sg=ITALY)
    unless (jd = _valid_jd?(jd, sg)) &&
	   (fr = _valid_time?(h, min, s))
      raise ArgumentError, 'invalid date'
    end
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

  def self.ordinal(y=-4712, d=1, h=0, min=0, s=0, of=0, sg=ITALY)
    unless (jd = _valid_ordinal?(y, d, sg)) &&
	   (fr = _valid_time?(h, min, s))
      raise ArgumentError, 'invalid date'
    end
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

  def self.civil(y=-4712, m=1, d=1, h=0, min=0, s=0, of=0, sg=ITALY)
    unless (jd = _valid_civil?(y, m, d, sg)) &&
	   (fr = _valid_time?(h, min, s))
      raise ArgumentError, 'invalid date'
    end
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

  class << self; alias_method :new, :civil end

  def self.commercial(y=-4712, w=1, d=1, h=0, min=0, s=0, of=0, sg=ITALY)
    unless (jd = _valid_commercial?(y, w, d, sg)) &&
	   (fr = _valid_time?(h, min, s))
      raise ArgumentError, 'invalid date'
    end
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

  def self.weeknum(y=-4712, w=0, d=1, f=0, h=0, min=0, s=0, of=0, sg=ITALY)
    unless (jd = _valid_weeknum?(y, w, d, f, sg)) &&
	   (fr = _valid_time?(h, min, s))
      raise ArgumentError, 'invalid date'
    end
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

  private_class_method :weeknum

  def self.nth_kday(y=-4712, m=1, n=1, k=1, h=0, min=0, s=0, of=0, sg=ITALY)
    unless (jd = _valid_nth_kday?(y, m, n, k, sg)) &&
	   (fr = _valid_time?(h, min, s))
      raise ArgumentError, 'invalid date'
    end
    if String === of
      of = Rational(zone_to_diff(of) || 0, 86400)
    end
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

#  private_class_method :nth_kday

  def self.new_by_frags(elem, sg)
    elem = rewrite_frags(elem)
    elem = complete_frags(elem)
    unless (jd = valid_date_frags?(elem, sg)) &&
	   (fr = valid_time_frags?(elem))
      raise ArgumentError, 'invalid date'
    end
    fr += (elem[:sec_fraction] || 0) / 86400
    of = Rational(elem[:offset] || 0, 86400)
    new!(jd_to_ajd(jd, fr, of), of, sg)
  end

  private_class_method :new_by_frags

  def self.strptime(str='-4712-01-01T00:00:00+00:00', fmt='%FT%T%z', sg=ITALY)
    elem = _strptime(str, fmt)
    new_by_frags(elem, sg)
  end

  def self.parse(str='-4712-01-01T00:00:00+00:00', comp=false, sg=ITALY)
    elem = _parse(str, comp)
    new_by_frags(elem, sg)
  end

  public :hour, :min, :sec, :sec_fraction, :zone, :offset, :new_offset,
	 :minute, :second, :second_fraction

  def to_s # 4p
    format('%.4d-%02d-%02dT%02d:%02d:%02d%s',
	   year, mon, mday, hour, min, sec, zone)
  end

end

class Time

  def to_time() getlocal end

  def to_date
    jd = Date.__send__(:civil_to_jd, year, mon, mday, Date::ITALY)
    Date.new!(Date.__send__(:jd_to_ajd, jd, 0, 0), 0, Date::ITALY)
  end

  if Time.allocate.respond_to?(:subsec)
    def to_datetime
      jd = DateTime.__send__(:civil_to_jd, year, mon, mday, DateTime::ITALY)
      fr = DateTime.__send__(:time_to_day_fraction, hour, min, [sec, 59].min) +
	Rational(subsec, 86400)
      of = Rational(utc_offset, 86400)
      DateTime.new!(DateTime.__send__(:jd_to_ajd, jd, fr, of),
		    of, DateTime::ITALY)
    end
  elsif Time.allocate.respond_to?(:nsec)
    def to_datetime
      jd = DateTime.__send__(:civil_to_jd, year, mon, mday, DateTime::ITALY)
      fr = DateTime.__send__(:time_to_day_fraction, hour, min, [sec, 59].min) +
	Rational(nsec, 86400_000_000_000)
      of = Rational(utc_offset, 86400)
      DateTime.new!(DateTime.__send__(:jd_to_ajd, jd, fr, of),
		    of, DateTime::ITALY)
    end
  else
    def to_datetime
      jd = DateTime.__send__(:civil_to_jd, year, mon, mday, DateTime::ITALY)
      fr = DateTime.__send__(:time_to_day_fraction, hour, min, [sec, 59].min) +
	Rational(usec, 86400_000_000)
      of = Rational(utc_offset, 86400)
      DateTime.new!(DateTime.__send__(:jd_to_ajd, jd, fr, of),
		    of, DateTime::ITALY)
    end
  end

end

class Date

  def to_time() Time.local(year, mon, mday) end
  def to_date() self end
  def to_datetime() DateTime.new!(jd_to_ajd(jd, 0, 0), @of, @sg) end

  def self.today(sg=ITALY)
    t = Time.now
    jd = civil_to_jd(t.year, t.mon, t.mday, sg)
    new!(jd_to_ajd(jd, 0, 0), 0, sg)
  end

  if Time.allocate.respond_to?(:subsec)
    def self.now(sg=ITALY)
      t = Time.now
      jd = civil_to_jd(t.year, t.mon, t.mday, sg)
      fr = time_to_day_fraction(t.hour, t.min, [t.sec, 59].min) +
	Rational(t.subsec, 86400)
      of = Rational(t.utc_offset, 86400)
      new!(jd_to_ajd(jd, fr, of), of, sg)
    end
  elsif Time.allocate.respond_to?(:nsec)
    def self.now(sg=ITALY)
      t = Time.now
      jd = civil_to_jd(t.year, t.mon, t.mday, sg)
      fr = time_to_day_fraction(t.hour, t.min, [t.sec, 59].min) +
	Rational(t.nsec, 86400_000_000_000)
      of = Rational(t.utc_offset, 86400)
      new!(jd_to_ajd(jd, fr, of), of, sg)
    end
  else
    def self.now(sg=ITALY)
      t = Time.now
      jd = civil_to_jd(t.year, t.mon, t.mday, sg)
      fr = time_to_day_fraction(t.hour, t.min, [t.sec, 59].min) +
	Rational(t.usec, 86400_000_000)
      of = Rational(t.utc_offset, 86400)
      new!(jd_to_ajd(jd, fr, of), of, sg)
    end
  end

  private_class_method :now

end

class DateTime < Date

  if Time.allocate.respond_to?(:nsec)
    def to_time
      d = new_offset(0)
      d.instance_eval do
	Time.utc(year, mon, mday, hour, min, sec +
		 sec_fraction)
      end.
	getlocal
    end
  else
    def to_time
      d = new_offset(0)
      d.instance_eval do
	Time.utc(year, mon, mday, hour, min, sec,
		 (sec_fraction * 1_000_000).to_i)
      end.
	getlocal
    end
  end

  def to_date() Date.new!(jd_to_ajd(jd, 0, 0), 0, @sg) end
  def to_datetime() self end

  private_class_method :today
  public_class_method  :now

end
