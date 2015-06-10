require 'ostruct'

class StackOverflow < Item
  def title
    @element.css('.job-link').inner_text.strip
  end

  def url
    relative_url = @element.css('.job-link').attribute('href')
    "http://careers.stackoverflow.com#{relative_url}"
  end
end

Search.london << OpenStruct.new(
  selector: '.listResults .-item',
  url: "http://careers.stackoverflow.com/jobs?searchTerm=ruby&location=London&range=20&distanceUnits=Miles&sort=p",
  item_class: StackOverflow
)

Search.remote << OpenStruct.new(
  selector: '.listResults .-item',
  url: "http://careers.stackoverflow.com/jobs?searchTerm=ruby&allowsremote=true&sort=p",
  item_class: StackOverflow
)

__END__
<div data-jobid="90054" class="-item -job can-apply">
  <p class="text _small _muted posted top">2 days ago<br /></p><a class="fav-toggle"
  data-jobid="90054" href=
  "/jobs/togglefavorite/90054?returnUrl=%2fjobs%3fsearchTerm%3druby%26location%3dLondon%26range%3d20%26distanceUnits%3dMiles%26sort%3dp"></a>

  <h3 class="-title"><a class="job-link" href=
  "/jobs/90054/devop-full-stack-developer-smoke-mirrors?a=uctRRkNy2ju&amp;searchTerm=ruby"
  title="DevOp / Full Stack Developer">DevOp / Full Stack
  Developer</a></h3><span class="badge -joelTest _inline" title=
  "Joel Test Score">9</span>

  <p class="text _small location"><strong class="-employer">Smoke &amp;
  Mirrors</strong>&nbsp;&bull; London, UK</p>

  <p class="text _muted">&nbsp;&nbsp; &nbsp;Node/Python/Ruby server-side web-dev
  experience</p>

  <div class="tags">
    <p><a class="post-tag job-link" href="/jobs/tag/node.js">node.js</a> <a class=
    "post-tag job-link" href=
    "/jobs/tag/continuous-integration">continuous-integration</a> <a class=
    "post-tag job-link" href="/jobs/tag/unix">unix</a> <a class="post-tag job-link"
    href="/jobs/tag/docker">docker</a> <a class="post-tag job-link" href=
    "/jobs/tag/javascript">javascript</a></p>
  </div>

  <p class="text _small posted bottom">2 days ago</p>
</div>
