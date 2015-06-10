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

<h3>Some more resources</h3>
<ul>
  <li>https://weworkremotely.com/</li>
  <li>https://jobs.github.com/positions?description=ruby&location=</li>
  <li>https://twitter.com/AngularHire</li>
  <li>https://twitter.com/rorjobs</li>
  <li>https://twitter.com/RailsJobsCom</li>
  <li>http://job-empleo.com/index.php/cod.search/what.ruby/vertical.jobs/d.job-empleo.com/lang.en_UK/where.Greater%20London/job_type.contract</li>
  <li>http://www.jobsite.co.uk/cgi-bin/advsearch?search_type=quick&engine=db&search_referer=internal&fp_skill_include=ruby&location_include=&location_within=20</li>
  <li>http://searchskyjobs.com/england/osterley-jobs</li>
  <li>https://nomadlist.com/</li>
  <li>https://unicornhunt.io/</li>
  <li>https://www.lytmus.io/</li>
  <li>http://www.bbc.co.uk/careers/what-we-do/online</li>
</ul>

<h3>Some more ideas</h3>
<ul>
  <li>Review meetups.</li>
  <li>Brainstorm other ways how to make money. Courses? Online courses? Moving towards start-up technical advising? HackHands?</li>
  <li>What more twitter searches would be useful?</li>
</ul>
