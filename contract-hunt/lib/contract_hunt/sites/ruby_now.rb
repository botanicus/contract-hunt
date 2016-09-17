# encoding: utf-8

class RubyNowJobsItem < Item
  def title
    @content.css("h2 a").inner_html
  end

  def description
    "NOT IMPLEMENTED YET"
  end
end
