# encoding: utf-8

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
