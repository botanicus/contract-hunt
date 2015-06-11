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
  <li>Pepa doporucuje https://angel.co/jobs#find/f!%7B%22types%22%3A%5B%22contract%22%5D%7D</li>
  <li>BTW https://www.odesk.com/o/profiles/users/_~01dafe2d81f69a7987/</li>
  <li>http://hnhiring.me/</li>
  <li>https://twitter.com/search?q=ruby%20contract%20OR%20freelance%20OR%20angular%20OR%20angular.js%20OR%20angularjs%20OR%20nodejs%20OR%20node.js%20OR%20RoR&src=typd</li>
  <li>http://careers.stackoverflow.com/jobs?searchTerm=ruby&allowsremote=True&sort=p</li>
  <li>http://jobmote.com/tag/ruby</li>
  <li>http://3-beards.com/jobs/type/contractor</li>
  <li>http://www.simplyhired.co.uk/a/jobs/list/qo-ruby+javascript/fjt-telecommute/fdb-30/ws-50</li>
  <li>http://www.theitjobboard.co.uk/index.php?Mode=AdvertSearch&lang=en&SearchTerms=Ruby&LocationSearchTerms=United+Kingdom&JobTypeFilter=1&</li>
  <li>https://www.linkedin.com/vsearch/j?keywords=ruby%20contract%20freelance&title=ruby&openAdvancedForm=true&locationType=I&countryCode=gb&sortBy=R&rsid=2391866571394535117613&orig=MDYS</li>
  <li>http://railyo.com/jobs</li>
  <li>https://www.angularjobs.com/</li>
  <li>LinkedIn Groups</li>
  <li>https://www.google.co.uk/search?q=where+to+find+remote+ruby+contracts#q=ruby+remote+contract&tbs=qdr:w</li>
  <li>http://www.cybercoders.com/search/?filtertype=contract&searchterms=ruby%20remote&searchlocation=&newsearch=true&sorttype=date</li>
  <li>http://adrocgroup.co.uk/hot-jobs/</li>
  <li>http://www.workingwithrails.com/jobs</li>
  <li>http://www.technojobs.co.uk/jobs/ruby/contract</li>
  <li>http://www.flexjobs.com/search?job_type=Freelance&search=ruby&tele_level=All+Telecommuting</li>
  <li>http://startuply.com/#/ruby%20radius%3A25%20telecommute%3Ayes/1</li>
  <li>http://workinstartups.com/job-board/jobs/programmers/freelance/</li>
  <li>http://workinstartups.com/job-board/jobs/programmers/parttime/</li>
  <li>https://jobs.github.com/positions?description=ruby+remote&location=</li>
  <li>https://weworkremotely.com/jobs/search?term=ruby</li>
  <li>http://jobs.rubynow.com/</li>
  <li>https://www.ruby-forum.com/search?query=contract&forums%5B%5D=4&forums%5B%5D=3&forums%5B%5D=9&forums%5B%5D=22&forums%5B%5D=31&forums%5B%5D=30&forums%5B%5D=19&forums%5B%5D=2&forums%5B%5D=32&max_age=1+month&sort_by_date=0</li>
  <li>https://www.ruby-forum.com/search?query=jobs&forums%5B%5D=4&forums%5B%5D=3&forums%5B%5D=9&forums%5B%5D=22&forums%5B%5D=31&forums%5B%5D=30&forums%5B%5D=19&forums%5B%5D=2&forums%5B%5D=32&max_age=1+month&sort_by_date=0</li>
  <li>https://www.ruby-forum.com/search?query=job&forums%5B%5D=4&forums%5B%5D=3&forums%5B%5D=9&forums%5B%5D=22&forums%5B%5D=31&forums%5B%5D=30&forums%5B%5D=19&forums%5B%5D=2&forums%5B%5D=32&max_age=1+month&sort_by_date=0</li>
  <li>http://berlinstartupjobs.com/contracting-positions/</li>
  <li>http://londonstartupjobs.co.uk/skills/ruby/</li>
  <li>http://jobs.rubyinside.com/a/jbb/find-jobs?oc=39&oc=7&jt=1&jt=2&jt=4&jt=32</li>
  <li>https://toprubyjobs.com/jobs?utf8=%E2%9C%93&filter%5B%5D=fulltime&filter%5B%5D=contract&filter%5B%5D=freelance&filter%5B%5D=remote&q=</li>
  <li>http://www.indeed.com/q-(ruby-or-javascript)-(remote-or-telecommute)-jobs.html</li>
  <li>http://www.jobisjob.co.uk/ruby-remote/jobs#what=ruby+remote&jobType=Contract&date=2013-04-24</li>
  <li>http://hackerjobs.co.uk/jobs?contract=1</li>
  <li>http://hackerjobs.co.uk/jobs?freelance=1</li>
  <li>http://www.flexjobs.com/search?old=2&search=ruby+javascript&exclude=&category=&jobtype=&flex=&levelt=Any+Level+of+Telecommuting&state=&country=</li>
  <li>http://www.rubygig.com/a/jbb/find-jobs?oc=1349&oc=773&jt=2&jt=4&jt=32</li>
  <li>http://jobs.trovit.co.uk/index.php/cod.search_jobs/what_d.ruby/where_d./telecommute.1/</li>
  <li>http://jobs.nodejs.org/a/jobs/find-jobs/sb-pd</li>
  <li>https://twitter.com/mirrorplacement</li>
  <li>https://news.ycombinator.com/item?id=5637663</li>
</ul>

<h3>Some more ideas</h3>
<ul>
  <li>Would Elance / ODesk work? This bloke is good https://www.elance.com/s/barandisolutions/10183/ coaching?</li>
  <li>More AngularJS. What else is trending? Scala, Go? Swift?</li>
  <li>https://clarity.fm - https://clarity.fm/browse/skills-management/productivity + ruby ... example: https://clarity.fm/twentytwenty/expertise/neurlolinguistic-programming-fear-elimination</li>
  <li>Review meetups.</li>
  <li>Brainstorm other ways how to make money. Courses? Online courses? https://www.udemy.com/teach/ Moving towards start-up technical advising? HackHands?</li>
  <li>What more twitter searches would be useful?</li>
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

I’ve had a number of super high end Rubyists consider straight forward plug-into-an-existing Ruby team-senior-Development style roles when in a better climate they would usually they take more holistic consultant style contracts at more money. The knock on from this is that the people who would normally take on the straightforward senior development role now have more competition.
