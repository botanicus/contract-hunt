require 'ostruct'

class GitHub < Item
  def title
    @element.css('.title h4:first').inner_text.strip
  end

  def url
    relative_url = @element.css('.title h4:first a').attribute('href')
    "https://jobs.github.com#{relative_url}"
  end

  def type
    @element.css('.vacType').inner_text.downcase
  end
end

Search.remote << OpenStruct.new(
  selector: '.positionlist tr',
  url: 'https://jobs.github.com/positions?description=ruby&location=Remote',
  item_class: GitHub
)

__END__
<tr>
  <td class="title">
    <h4><a href="/positions/03a031fe-0f86-11e5-9be5-0080665968f3">Experienced Software Engineer</a></h4>
    <p class="source">
      <a href="/companies/Loco2" class="company">Loco2</a>
      –
      <strong class="fulltime">Full Time</strong></p>
  </td>
  <td class="meta">
    <span class="location">Remote</span>
    <span class="when relatize relatized">1 day ago</span>
  </td>
</tr>
