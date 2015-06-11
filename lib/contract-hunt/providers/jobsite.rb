require 'ostruct'

class JobSite < Item
  def title
    @element.css('h3:first').inner_text.strip
  end

  def url
    relative_url = @element.css('h3:first a').attribute('href').text.strip
    "http://www.jobsite.co.uk#{relative_url}"
  end

  def type
    @element.css('.vacType').inner_text.downcase
  end

  def valid?
    super && self.type.match(/contract/)
  end
end

Search.london << OpenStruct.new(
  selector: '#vacs .vacRow',
  url: 'http://www.jobsite.co.uk/vacancies?search_type=quick&engine=solr&search_referer=internal&query=ruby&location=London&radius=50',
  item_class: JobSite
)

__END__
<div class="clearfix">
  <h3>
    <a href="
/job/ruby-on-rails-developerrubyrubyruby-953422469?src=search&amp;tmpl=lin&amp;sctr=IT&amp;position=1&amp;page=1&amp;engine=solr&amp;search_referer=internal">
    Ruby-on-Rails Developer Ruby / Ruby / Ruby
    </a>
  </h3>

  <p class="jobDesc"> <strong> Ruby </strong> -on-Rails Developer needed to join a well-established E-Commerce platform business at the cutting edge of modern technology. As a Strong  <strong> Ruby </strong> -on-Rails developer you will often see opportunities around but nothing that compares to this unique and progressive company. This  <strong> Ruby </strong> -on-Rails role will challenge you technically but give you a real understanding of what one of the leading  <strong> Ruby </strong> -on-Rails...
  </p>

  <dl class="vacancyDetails clearfix">
    <dt class="vacSalary">Salary:</dt><dd class="vacSalary"> £50k - £57k pa + Pension , Bonus</dd>
    <dt class="vacLocation">Location:</dt><dd class="vacLocation">London</dd>
    <dt class="vacPosted">Date Posted:</dt><dd class="vacPosted">05-Jun-2015</dd>
    <dt class="vacType">Job Type:</dt><dd class="vacType">Permanent</dd>
  </dl>
</div>
