# encoding: utf-8

class Signals < Item
  def match?
    @content.css(".city").to_html.match("Anywhere")
  end

  def title
    @content.css(".title")
  end

  def description
    "TO BE DONE"
  end
end
