#!/usr/bin/env ruby
# encoding: utf-8

# TODO: add http://workinstartups.com/job-board/jobs/programmers/freelance/
# http://careers.stackoverflow.com/jobs?searchTerm=ruby&range=20&istelecommute=true

# Try using Google, something like site:groups.google.com ruby remote work
# http://www.indeed.com/jobs?as_and=ruby&as_phr=&as_any=remote+telecommute&as_not=&as_ttl=&as_cmp=&jt=all&st=&salary=&radius=25&l=&fromage=15&limit=50&sort=&psf=advsrch

require "open-uri"
require "nokogiri"
require "yaml"
require "uri"

class Site
  attr_accessor :url, :item_pattern

  def initialize(log, item_class, url, item_pattern)
    @log, @item_class, @url, @item_pattern = log, item_class, url, item_pattern
  end

  def content
    @content ||= begin
      open(self.url) do |stream|
        stream.read
      end
    end
  end

  def document
    @document ||= begin
      Nokogiri::HTML(self.content)
    end
  end

  def base_url
    uri = URI(@url)
    "#{uri.scheme}://#{uri.host}"
  end

  def items
    self.document.css(self.item_pattern).map do |content|
      @item_class.new(@log, self.base_url, content)
    end.
      select { |item| item.match? && item.new? }
  end
end

class Log
  def self.path
    "/var/matched_contracts.yml"
  end

  def self.load
    hash = YAML::load(File.read(self.path))
    raise unless hash.respond_to?(:[])
    self.new(hash)
  rescue
    self.new(Hash.new)
  end

  attr_reader :hash
  def initialize(hash)
    @hash = hash
  end

  def [](base_url)
    @hash[base_url] ||= Array.new
  end

  def save
    File.open(self.class.path, "w") do |file|
      file.puts(@hash.to_yaml)
    end
  end
end

class Item
  attr_reader :content, :base_url

  def initialize(log, base_url, content)
    @log, @base_url, @content = log, base_url, content
  end

  def match?
    @content.to_html.match(/remote|telecommute/i)
  end

  def link
    @content.css("a").first.attribute("href").value
  end

  def url
    if self.link.start_with?("/")
      self.base_url + self.link
    else
      self.link
    end
  end

  def new?
    ! @log[self.base_url].include?(self.url)
  end

  def save_to_digest
    File.open("/var/contract_digest.txt", "a") do |file|
      file.puts(self.to_digest)
    end

    self.log_as_read
  end

  def log_as_read
    @log[base_url] << self.url
  end

  def to_digest
    <<-HTML
<h3><a href="#{self.url}">#{self.title}</a></h3>
<p>
  #{self.description}
</p>
    HTML
  end

  def inspect
    @content.to_html
  end
end

class TopRubyJobsItem < Item
  def match?
    @content.css(".job-type").to_html.match("Remote")
  end

  def title
    @content.css("h4.job-title a").inner_html
  end

  def description
    @content.css("p.job-info").inner_html + "<br>" + @content.css("p.job-type").inner_html
  end
end

class RubyInsideJobsItem < Item
  def title
    @content.css("td.title a").inner_html
  end

  def description
    date = @content.css(".posted_date").inner_html
    company = @content.css(".company").inner_html
    location = @content.css(".location").inner_html

    "#{date} | #{company} | #{location}"
  end
end

class RubyNowJobsItem < Item
  def title
    @content.css("h2 a").inner_html
  end

  def description
    "NOT IMPLEMENTED YET"
  end
end

class StartuplyItem < Item
  def match?
    true # It's filtered on the URL level already.
  end

  def link
    @content.css("a").map { |a| a.attribute("href").value }.find { |href| href.match(/\/Jobs\//) }
  end

  def title
    @content.css("a").find { |a| a.attribute("href").value.match(/\/Jobs\//) }.inner_html
  end

  def description
    "NOT AVAILABLE"
  end
end

class GithubJobsItem < Item
  def title
    @content.css(".title h4 a").inner_html
  end

  def description
    "NOT AVAILABLE"
  end
end

class RailsJobsInItem < Item
  def title
    @content.css("h3 a").inner_html
  end

  def description
    @content.css(".teaser").inner_html # there's more though
  end
end

log = Log.load

begin
  [
    Site.new(log, TopRubyJobsItem, "http://toprubyjobs.com/", "ul#jobs li.job"),
    Site.new(log, RubyInsideJobsItem, "http://jobs.rubyinside.com/a/jbb/find-jobs?oc=39&oc=7&jt=1&jt=2&jt=4&jt=32", "#listings .listing"),
    Site.new(log, RubyNowJobsItem, "http://jobs.rubynow.com/", ".jobs li"),
    Site.new(log, StartuplyItem, "http://startuply.com/#/ruby%20radius%3A25%20telecommute%3Ayes/1", "#jobTable tbody tr"),
    Site.new(log, GithubJobsItem, "https://jobs.github.com/positions?description=ruby&location=", ".positionlist tr"),
    Site.new(log, RailsJobsInItem, "http://railsjobs.in/", ".job")
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

