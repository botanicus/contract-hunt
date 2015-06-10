#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'contract-hunt'
require 'erb'
require 'yaml'
require 'pry'

# Has to be mount as a volume || use Redis.
DATA_DIR = ARGV.shift
CACHE_FILE = File.join(DATA_DIR, 'contract-hunt.yml')

PROCESSED_URLS = begin
  YAML.load_file(CACHE_FILE)
rescue # Whether the file doesn't exist or any other problem.
  Array.new
end

def run(searches)
  searches.reduce(Array.new) do |buffer, search|
    open(search.url) do |stream|
      document = Nokogiri::HTML(stream.read)
      document.css(search.selector).each do |element|
        item = search.item_class.new(element)
        unless PROCESSED_URLS.include?(item.url)
          buffer << item
          PROCESSED_URLS << item.url
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

File.open(CACHE_FILE, 'w') do |file|
  file.puts(PROCESSED_URLS.to_yaml)
end

__END__
<h3>London</h3>
<ul>
  <% london.each do |item| %>
    <li><%= item.to_html %></li>
  <% end %>
</ul>

<h3>Remote</h3>
<ul>
  <% remote.each do |item| %>
    <li><%= item.to_html %></li>
  <% end %>
</ul>

<p>
  <em>Don't forget to check out <a href="https://www.toptal.com/platform/developer/jobs">TopTal jobs</a>.</em>
</p>
