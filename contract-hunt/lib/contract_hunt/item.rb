# encoding: utf-8

class Item
  attr_reader :content, :base_url

  def initialize(log, base_url, content)
    @log, @base_url, @content = log, base_url, content
  end

  def match?
    @content.to_html.match(/remote|telecommute|anywhere/i)
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
