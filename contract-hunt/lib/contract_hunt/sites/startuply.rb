# encoding: utf-8

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
