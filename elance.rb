#!/usr/bin/env ruby

require 'open-uri'
require 'ostruct'
require 'nokogiri'

feeds = [
  'https://www.elance.com/r/rss/jobs/q-angular/hry-true/rte-gt50-ns1',
  'https://www.elance.com/r/rss/jobs/hry-true/rte-gt50-ns1/q-ruby'
]

items = feeds.reduce(Array.new) do |items, feed_url|
  open(feed_url) do |io|
    document = Nokogiri::XML(io.read)
    document.css('item').each do |item|
      title = item.css('title').inner_text.sub(' | Elance Job', '')
      link  = item.css('link').inner_text
      desc  = item.css('description').inner_text
      rate  = desc.match(/<b>Type and Budget:<\/b> Hourly \((.+)\)<br \/>/)[1]
      next if rate == 'Not Sure'
      items << OpenStruct.new(title: title, link: link, desc: desc, rate: rate)
    end
  end

  items
end

items.each do |item|
  puts "#{item.title} #{item.rate}"
  puts item.link
  puts
end
