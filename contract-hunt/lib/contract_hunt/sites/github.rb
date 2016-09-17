# encoding: utf-8

class GithubJobsItem < Item
  def title
    @content.css(".title h4 a").inner_html
  end

  def description
    "NOT AVAILABLE"
  end
end
