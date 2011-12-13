#!/usr/bin/env ruby
# encoding: utf-8

root_dir = File.dirname(File.expand_path(__FILE__))

require "cairo"
require "#{root_dir}/lib/ruby/date2/lib/date"
require "#{root_dir}/lib/ruby/date2/lib/date/holiday"


width = 910
height = 850

cell_width = width / 7
cell_height = (height - 150) / 5

format = Cairo::FORMAT_ARGB32

surface = Cairo::ImageSurface.new(format, width, height)
context = Cairo::Context.new(surface)

# 日付
today = Date.today

months = ["January", "Feburary", "March", "April", "May", "June", "July",
         "August", "September", "Octerber", "November", "December"]

weekday = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

days = {1=>31, 2=>28, 3=>31, 4=>20, 5=>31, 6=>30, 7=>31, 8=>31, 9=>30, 10=>31, 11=>30, 12=>31}

#閏年
if today.year%4 == 0 and today.year%100 != 0 or today.year%400 == 0
  days[2] = 29
end

first_day_of_month = today.wday - (today.day % 7) + 1

# 数字描画
context.set_source_rgb(0.3, 0.3, 0.3)
context.select_font_face("Arial")
context.set_font_size(120)
context.move_to(0, 100)

context.show_text(sprintf("%02d", today.day))

# 月名
context.set_font_size(30)
context.move_to(140, 40)
context.show_text(months[today.month-1])

#year
context.move_to(140, 70)
context.show_text(today.year.to_s)

#week

context.set_font_size(20)

7.times do |ind|
  context.move_to(ind * cell_width, 140)
  context.show_text(weekday[ind])
end

#days
calendar_offset = 150

context.set_font_size(30)

(days[today.month]).times do |ind|
  offsetw = (ind + first_day_of_month) % 7
  offseth = (ind + first_day_of_month) / 7

  date = Date.new(today.year, today.month, ind+1)
  if date == today
    context.set_source_rgba(0.6, 1.0, 0.6, 0.4)
    context.rectangle(offsetw * cell_width, calendar_offset + (offseth * cell_height), cell_width, cell_height)
    context.fill

  elsif date.national_holiday? or date.sunday? or date.saturday?
    context.set_source_rgba(0.6, 0.6, 0.6, 0.4)
    context.rectangle(offsetw * cell_width, calendar_offset + (offseth * cell_height), cell_width, cell_height)
    context.fill
  end

  context.rectangle(offsetw * cell_width, calendar_offset + (offseth * cell_height), cell_width, cell_height)
  context.set_source_rgb(0.6, 0.6, 0.6)
  context.stroke

  context.move_to(offsetw * cell_width + 10, calendar_offset + (offseth * cell_height) + 30)
  context.set_source_rgb(0.3, 0.3, 0.3)
  context.show_text((ind + 1).to_s)

end

surface.write_to_png("#{root_dir}/img/calendar.png")

