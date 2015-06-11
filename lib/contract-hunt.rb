require 'open-uri'
require 'nokogiri'

class Search
  def self.london
    @london ||= Array.new
  end

  def self.remote
    @remote ||= Array.new
  end
end

class Item
  attr_reader :element
  def initialize(element)
    @element = element
  end

  def valid?
    self.to_html.match(/ruby|rails|javascript|angular/i)
  end

  def to_html
    <<-HTML.strip
      [#{self.class.name}] <a href="#{self.url}">#{self.title}</a>
    HTML
  end
end

require 'contract-hunt/providers/stackoverflow'
require 'contract-hunt/providers/lrug'
require 'contract-hunt/providers/twitter_search'
require 'contract-hunt/providers/theitjobboard'
require 'contract-hunt/providers/jobsite'
require 'contract-hunt/providers/github'
