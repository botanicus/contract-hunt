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
    begin
      open(search.url) do |stream|
        document = Nokogiri::HTML(stream.read)
        document.css(search.selector).each do |element|
          item = search.item_class.new(element)
          begin
            if item.valid? && ! PROCESSED_URLS.include?(item.url)
              buffer << item
              PROCESSED_URLS << item.url
            end
          rescue Exception => error
            STDERR.puts("~ DEBUG #{item.class}")
            raise error
          end
        end
      end

      buffer
    rescue Exception => error
      unless ENV['DBG']
        STDERR.puts("! #{error.class}: #{error.message}")
        STDERR.puts("  - " + error.backtrace.join("\n  - "))
      else
        raise error
      end
    ensure
      buffer
    end
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
<h2>Ruby</h2>
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

<h2>JavaScript &amp; Angular.js</h2>
<em>Not done yet. Check out these:</em>
<ul>
  <li>https://twitter.com/AngularHire</li>
  <li>https://www.angularjobs.com/</li>
  <li>https://twitter.com/search?q=ruby%20contract%20OR%20freelance%20OR%20angular%20OR%20angular.js%20OR%20angularjs%20OR%20nodejs%20OR%20node.js%20OR%20RoR&src=typd</li>
</ul>

<h3>Sign-up required</h3>
<ul>
  <li><a href="https://www.toptal.com/platform/developer/jobs">TopTal jobs</a></li>
  <li><a href="https://angel.co/jobs#find/f!%7B%22types%22%3A%5B%22contract%22%5D%7D">Angel List</a> (Josef recommends)</li>
  <li>https://www.linkedin.com/vsearch/j?keywords=ruby%20contract%20freelance&title=ruby&openAdvancedForm=true&locationType=I&countryCode=gb&sortBy=R&rsid=2391866571394535117613&orig=MDYS</li>
  <li>LinkedIn Groups</li>
</ul>

<h3>Another ideas</h3>
<ul>
  <li><a href="https://www.google.co.uk/search?q=where+to+find+remote+ruby+contracts#q=ruby+remote+contract&tbs=qdr:w">Google it</a></li>
</ul>

<h3>Currently unavailable</h3>
<ul>
  <li><a href="http://hackerjobs.co.uk/jobs?contract=1">HackerJobs contracts</a> and <a href="http://hackerjobs.co.uk/jobs?freelance=1">HackerJobs freelance</a></li>
</ul>

<h3>Some more ideas</h3>
<ul>
  <li>Would Elance / ODesk work? <a href="https://www.upwork.com/o/profiles/users/_~01dafe2d81f69a7987/">ODesk example</a>, <a href="https://www.elance.com/s/barandisolutions/10183/">Elance example</a>. Coaching?</li>
  <li>More AngularJS. What else is trending? Scala, Go? Swift?</li>
  <li>https://clarity.fm - https://clarity.fm/browse/skills-management/productivity + ruby ... example: https://clarity.fm/twentytwenty/expertise/neurlolinguistic-programming-fear-elimination</li>
  <li>Review meetups.</li>
  <li>Brainstorm other ways how to make money. Courses? Online courses? https://www.udemy.com/teach/ Moving towards start-up technical advising? HackHands?</li>
  <li>What more twitter searches would be useful?</li>
  <li>Who is hiring? <a href="http://searchskyjobs.com/england/osterley-jobs">Sky</a>, <a href="http://www.bbc.co.uk/careers/what-we-do/online">BBC</a>, Pivotal?
  <li><a href="https://news.ycombinator.com/item?id=5637663">Who's hiring on HN</a></li>
</ul>

<h3>What else can help?</h3>
<ul>
  <li>Finally review your CV.</li>
  <li>Finally review your LinkedIn.</li>
  <li>Work on your online presence. Twitter, blog.</li>
  <li>Review portfolio. How can you market it better?</li>
  <li>Anyone subscribed to my newsletter?</li>
  <li>Review Streak pipeline.</li>
  <li>Might be useful reading: http://mirrorplacement.com/blog</li>
</ul>

<p>
  <em>I’ve had a number of super high end Rubyists consider straight forward
  plug-into-an-existing Ruby team-senior-Development style roles when in
  a better climate they would usually they take more holistic consultant
  style contracts at more money. The knock on from this is that the people
  who would normally take on the straightforward senior development role
  now have more competition.</em>
</p>
