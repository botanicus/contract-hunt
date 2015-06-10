#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'contract-hunt'
require 'erb'
require 'yaml'
require 'pry'

# Has to be mount as a volume || use Redis.
PROCESSED_URLS = YAML::load_file()

def run(searches)
  searches.reduce(Array.new) do |buffer, search|
    open(search.url) do |stream|
      document = Nokogiri::HTML(stream.read)
      document.css(search.selector).each do |element|
        item = search.item_class.new(element)
        unless PROCESSED_URLS.include?(item.url)
          buffer << item
        end
      end
    end

    buffer
  end
end

london = run(Search.london)
remote = run(Search.remote)

renderer = ERB.new(DATA.read)
puts renderer.result(binding)

__END__
<h3>London</h3>
<ul>
  <% london.each do |item| %>
    <li><a href="<%= item.url %>"><%= item.title %></a></li>
  <% end %>
</ul>

<h3>Remote</h3>
<ul>
  <% remote.each do |item| %>
    <li><a href="<%= item.url %>"><%= item.title %></a></li>
  <% end %>
</ul>
