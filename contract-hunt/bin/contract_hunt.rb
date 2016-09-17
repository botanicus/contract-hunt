#!/usr/bin/env ruby
# encoding: utf-8

require_relative '../lib/contract_hunt'

__END__
log = Log.load

begin
  [
    Site.new(log, TopRubyJobsItem, "http://toprubyjobs.com/", "ul#jobs li.job"),
    Site.new(log, RubyInsideJobsItem, "http://jobs.rubyinside.com/a/jbb/find-jobs?oc=39&oc=7&jt=1&jt=2&jt=4&jt=32", "#listings .listing"),
    Site.new(log, RubyNowJobsItem, "http://jobs.rubynow.com/", ".jobs li"),
    #Site.new(log, StartuplyItem, "http://startuply.com/#/ruby%20radius%3A25%20telecommute%3Ayes/1", "#jobTable tbody tr"),
    Site.new(log, GithubJobsItem, "https://jobs.github.com/positions?description=ruby&location=", ".positionlist tr"),
    Site.new(log, RailsJobsInItem, "http://railsjobs.in/", ".job"),
    Site.new(log, Signals, "http://jobs.37signals.com/categories/2/jobs", "li.feature"),
    Site.new(log, WorkInStartups, "http://workinstartups.com/job-board/jobs/programmers/freelance/", ".badge-freelance"),
    Site.new(log, WorkInStartups, "http://workinstartups.com/job-board/jobs/programmers/parttime/", ".badge-parttime")
  ].each do |site|
    puts "~ Processing site #{site.base_url} ..."
    site.items.each do |item|
      puts "  ~> #{item.url}"
      item.save_to_digest
    end
  end
ensure
  log.save
end
