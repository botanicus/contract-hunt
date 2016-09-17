# encoding: utf-8

class RailsJobsInItem < Item
  def title
    @content.css("h3 a").inner_html
  end

  def description
    @content.css(".teaser").inner_html # there's more though
  end
end
