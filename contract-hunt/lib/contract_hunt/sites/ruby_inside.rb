# encoding: utf-8

class RubyInsideJobsItem < Item
  def title
    @content.css("td.title a").inner_html
  end

  def description
    date = @content.css(".posted_date").inner_html
    company = @content.css(".company").inner_html
    location = @content.css(".location").inner_html

    "#{date} | #{company} | #{location}"
  end
end
