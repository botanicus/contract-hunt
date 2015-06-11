require 'ostruct'

class TheITJobBoard < Item
  def title
    @element.css('h2:first').inner_text.strip
  end

  def url
    relative_url = @element.css('a[itemprop=url]').attribute('href')
  end
end

Search.london << OpenStruct.new(
  selector: '#SearchResults .borderTopHalfThickBlack',
  url: 'http://www.theitjobboard.co.uk/index.php?SearchTerms=ruby&LocationSearchTerms=London&RadiusUnit=2&JobTypeFilter_1=1&Mode=AdvertSearch&LocationId=2047895&lang=en&Radius=50',
  item_class: TheITJobBoard
)

__END__
<div class="column4of4 paddingBottom30 borderTopHalfThickBlack">
  <div class="row">
    <div id="SingleAdvertTop_1" class=
    "col-xs-12 col-sm-12 col-md-12 col-lg-12 searchResultTitle">
      <hr class="hrBorderSolidThin marginBottom10" />

      <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
          <h2 itemtype="http://schema.org/JobPosting" itemscope="itemscope" class=
          "marginBottom10 standardLink"><a itemprop="url" href=
          "http://www.theitjobboard.co.uk/IT-Job/Ruby-on-Rails-Senior-Developer/9539736/en/?xc=247&amp;SearchTerms=ruby&amp;LocationSearchTerms=London&amp;JobTypeFilter=1&amp;Currency=GBP&amp;LocationId=2047895&amp;Radius=50&amp;RadiusUnit=2&amp;source=search"
          id="TITLE[9539736]">Ruby on Rails Senior Developer</a></h2>
          <hr class="hrBorderDotted marginBottom10 hidden-md hidden-lg" />

          <p class="jobMeta hidden-xs hidden-sm"><span class="bold">Salary:</span>
          <span id="SALARY[9539736]">&#163;400 - &#163;550 per day</span> |
          <span class="bold">Location:</span> <span id=
          "FREE_LOCATION[9539736]">London</span> | <span class="bold">Distance:</span>
          <span id="DISTANCE[9539736]">&nbsp;0&nbsp;Miles</span> | <span class=
          "bold">Job Type:</span> <span id="JOB_TYPE[9539736]">Contract</span><br />
          <span class="bold" id="CLIENTNAME[9539736]">Advertiser:</span> <span id=
          "CONTACT_OFFICE[9539736]">Explore Recruitment Solutions</span> | <span class=
          "bold">Last Updated Date:</span> <span id=
          "POSTED_DATE[9539736]">14-May-2015</span></p>
        </div>

        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 hidden-xs hidden-sm"></div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-6 col-sm-6 col-md-9 col-lg-9">
      <hr class="hrBorderDotted marginBottom10 hidden-xs hidden-sm" />

      <table cellspacing="0" cellpadding="0" itemtype="http://schema.org/Organization"
      itemscope="" itemprop="hiringOrganization" class=
      "table table-condensed hidden-md hidden-lg">
        <tbody>
          <tr>
            <th class="bold"><span class="fa fa-user">&nbsp;</span><span class=
            "displayNone">Advertiser</span></th>

            <td id="CONTACT_OFFICE[9539736]">Explore Recruitment Solutions</td>
          </tr>

          <tr>
            <th class="bold"><span class="fa fa-gbp">&nbsp;</span><span class=
            "displayNone">Salary</span></th>

            <td id="SALARY[9539736]">&#163;400 - &#163;550 per day</td>
          </tr>

          <tr>
            <th class="bold"><span class="fa fa-globe">&nbsp;</span><span class=
            "displayNone">Location</span></th>

            <td id="FREE_LOCATION[9539736]">London</td>
          </tr>

          <tr>
            <th class="bold"><span class="fa fa-calendar">&nbsp;</span><span class=
            "displayNone">Last Updated Date</span></th>

            <td id="POSTED_DATE[9539736]">14-May-2015</td>
          </tr>

          <tr>
            <th class="bold"><span class="fa fa-users">&nbsp;</span><span class=
            "displayNone">Job Type</span></th>

            <td id="JOB_TYPE[9539736]">Contract</td>
          </tr>
        </tbody>
      </table>

      <div id="SingleAdvertBottom_1" class="hidden-xs hidden-sm">
        <p class="paddingTop10" id="SYNOPSIS[9539736]">Ruby on Rails/Ruby
        Developer/RoR/Ruby/Rails Developer/Ruby Engineer/Senior/London/Contract/Up to
        &#163;550pd Looking for a senior Ruby on Rails developer to join an exciting
        retail company working on their online e-commerce platform in London. The
        company...</p>
      </div>
    </div>

    <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
      <div id="SingleAdvert">
        <div class="paddingTop10">
          <div class="germanRedButton">
            <a class="btn-default btn-block btn redButton noMargin" id=
            "view_advert_link[9539736]" href=
            "http://www.theitjobboard.co.uk/IT-Job/Ruby-on-Rails-Senior-Developer/9539736/en/?xc=247&amp;SearchTerms=ruby&amp;LocationSearchTerms=London&amp;JobTypeFilter=1&amp;Currency=GBP&amp;LocationId=2047895&amp;Radius=50&amp;RadiusUnit=2&amp;source=search">
            View Job</a>
          </div>
        </div>

        <div class="shortListResultsContainer">
          <a href="#" class="btn-default btn greyButtonSmall" id=
          "AddToShortlistLoggedOut_9539736">+ Add job to shortlist</a><a href="#"
          class="btn-default btn greyButtonSmall shortListDisplayNone" disabled=
          "disabled" id="AddToShortlistLoggedOutAlert_9539736">You must be signed in to
          shortlist jobs</a>
        </div>
      </div>
    </div>
  </div>
</div>
