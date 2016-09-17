# encoding: utf-8

class WorkInStartups < Item
  def match?
    super && self.title.match(/ruby|rails|javascript|node\.js/i)
  end

  def title
    @content.css(".job-link").attribute("title").value
  end

  def description
    "TO BE DONE"
  end
end
