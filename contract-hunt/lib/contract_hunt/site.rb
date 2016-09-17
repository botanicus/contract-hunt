# encoding: utf-8

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
