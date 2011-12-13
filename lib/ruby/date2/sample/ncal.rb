#! /usr/bin/env ruby
# encoding: euc-jp

# ncal.rb: Written by Tadayoshi Funaba 1998-2004,2006,2008
# $Id: ncal.rb,v 2.11 2008-01-12 10:54:29+09 tadf Exp $

require 'date'
require 'date/holiday'

class Cal

  START =
    {
    'cn' => Date::GREGORIAN, # China
    'de' => 2342032,         # Germany (protestant states)
    'dk' => 2342032,         # Denmark
    'es' => 2299161,         # Spain
    'fi' => 2361390,         # Finland
    'fr' => 2299227,         # France
    'gb' => 2361222,         # United Kingdom
    'gr' => 2423868,         # Greece
    'hu' => 2301004,         # Hungary
    'it' => 2299161,         # Italy
    'jp' => Date::GREGORIAN, # Japan
    'no' => 2342032,         # Norway
    'pl' => 2299161,         # Poland
    'pt' => 2299161,         # Portugal
    'ru' => 2421639,         # Russia
    'se' => 2361390,         # Sweden
    'us' => 2361222,         # United States
    'os' => Date::JULIAN,    # (old style)
    'ns' => Date::GREGORIAN  # (new style)
  }

  DEFAULT_START = 'jp'

  def initialize
    opt_j; opt_m; opt_t; opt_y; opt_c; tty
  end

  def opt_j(flag=false) @opt_j = flag end
  def opt_m(flag=false) @opt_m = flag end
  def opt_t(flag=false) @opt_t = flag end
  def opt_y(flag=false) @opt_y = flag end

  def opt_c(arg=DEFAULT_START) @start = START[arg] end

  def tty(flag=false) @tty = flag end

  def set_params
    @dw = if @opt_j then 3 else 2 end
    @mw = (@dw + 1) * 7 - 1
    @mn = if @opt_j then 2 else 3 end
    @tw = (@mw + 2) * @mn - 2
    @k  = if @opt_m then 1 else 0 end
    @da = if @opt_j then :yday else :mday end
    @es = @tty
  end

  def pict(y, m)
    d = (1..31).detect{|x| Date.valid_date?(y, m, x, @start)}
    fi = Date.new(y, m, d, @start)
    fi -= (fi.jd - @k + 1) % 7

    ve  = (fi..fi +  6).collect{|cu|
      [ %w(�� �� �� �� �� �� ��)[cu.wday],
       [31, 0, 0, 0, 0, 0, 34][cu.wday] ]
    }
    ve += (fi..fi + 41).collect{|cu|
      [ if cu.mon == m then cu.send(@da) end.to_s,
	if cu.mon == m && cu.national_holiday? then 41
	else [31, 0, 0, 0, 0, 0, 34][cu.wday] end ]
    }

    ve = ve.collect{|e, n| esc(e.rjust(@dw), n)}

    gr = group(ve, 7)
    gr = trans(gr) if @opt_t
    ta = gr.collect{|xs| xs.join(' ')}

    ca = %w(�ӷ� ǡ�� ���� ���� ���� ��̵��
	    ʸ�� �շ� Ĺ�� ��̵�� ���� ����)[m - 1]
    ca = y.to_s + 'ǯ ' + ca if !@opt_y
    ca = esc(ca.center(@mw), 1)

    ta.unshift(ca)
  end

  def esc2(n)
    if @es then "\e[" + n.to_s + "m" else '' end
  end

  def esc(s, n)
    esc2(n) + s + esc2(0)
  end

  def group(xs, n)
    (0..xs.size / n - 1).collect{|i| xs[i * n, n]}
  end

  def trans(xs)
    (0..xs[0].size - 1).collect{|i| xs.collect{|x| x[i]}}
  end

  def stack(xs)
    if xs.empty? then [] else xs[0] + stack(xs[1..-1]) end
  end

  def block(xs, n)
    stack(group(xs, n).collect{|ys| trans(ys).collect{|zs| zs.join('  ')}})
  end

  def unlines(xs)
    xs.collect{|x| x + "\n"}.join
  end

  def monthly(y, m)
    unlines(pict(y, m))
  end

  def addmon(y, m, n)
    y, m = (y * 12 + (m - 1) + n).divmod(12)
    return y, m + 1
  end

  def yearly(y)
    esc((y.to_s + 'ǯ').center(@tw), 1) + "\n\n" +
      unlines(block((0..11).collect{|n| pict(*addmon(y, 1, n))}, @mn)) + "\n"
  end

  def print(y, m)
    set_params
    if @opt_y then yearly(y) else monthly(y, m) end
  end

end

if __FILE__ == $0

  require 'getoptlong'

  def usage
    warn 'usage: ncal [-c iso3166] [-jmty] [[month] year]'
    exit 1
  end

  cal = Cal.new

  begin
    GetoptLong.new(['-c', GetoptLong::REQUIRED_ARGUMENT],
		   ['-j', GetoptLong::NO_ARGUMENT],
		   ['-m', GetoptLong::NO_ARGUMENT],
		   ['-t', GetoptLong::NO_ARGUMENT],
		   ['-y', GetoptLong::NO_ARGUMENT]).
    each do |opt, arg|
      case opt
      when '-c'; cal.opt_c(arg) || raise
      when '-j'; cal.opt_j(true)
      when '-m'; cal.opt_m(true)
      when '-t'; cal.opt_t(true)
      when '-y'; cal.opt_y(true)
      end
    end
  rescue
    usage
  end

  y, m = ARGV.values_at(1, 0).compact.collect{|x| x.to_i}
  cal.opt_y(true) if y && !m

  to = Date.today
  y ||= to.year
  m ||= to.mon

  usage unless m >= 1 && m <= 12
  usage unless y >= -4712

  cal.tty($stdout.tty?)

  print cal.print(y, m)

end

# See Bird & Wadler's Introduction to functional programming 4.5.
