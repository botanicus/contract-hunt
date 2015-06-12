require 'ostruct'

class TwitterSearch < Item
  def nickname
    @element.css('.stream-item-header').inner_text.strip.split(/ +/)[1].strip
  end

  def tweet
    @element.css('.tweet-text').inner_text.strip
  end
  alias_method :title, :tweet # For #valid?

  def url
    relative_url = @element.css('.stream-item-header .time a:first').attribute('href')
    "https://twitter.com#{relative_url}"
  end

  def to_html
    <<-HTML.strip
      [#{self.class.name}] <a href="#{self.url}">#{self.nickname}</a> #{self.tweet}
    HTML
  end
end

Search.london << OpenStruct.new(
  selector: '.stream.search-stream .content',
  url: "https://twitter.com/search?q=ruby%20london%20contract&src=typd",
  item_class: TwitterSearch
)

[
  'https://twitter.com/rorjobs', # Does these work or just the search?
  'https://twitter.com/RailsJobsCom',
  'https://twitter.com/mirrorplacement',
  'https://twitter.com/search?q=contract%20ruby&src=typd'
].each do |url|
  Search.remote << OpenStruct.new(
    selector: '.stream.search-stream .content',
    url: url,
    item_class: TwitterSearch
  )
end

__END__
<div class="content">
  <div class="stream-item-header">
    <a class="account-group js-account-group js-action-profile js-user-profile-link js-nav"
    href="/botanicus" data-user-id="14223716">
    <img class="avatar js-action-profile-avatar" src="https://pbs.twimg.com/profile_images/1850315260/james_bigger.png" alt="" />
    <strong class="fullname js-action-profile-name show-popup-with-id"
    data-aria-label-part="">botanicus</strong>
    <span>&rlm;</span><span class="username js-action-profile-name" data-aria-label-part=
    ""><s>@</s><b>botanicus</b></span></a>
    <small class="time"><a href=
    "/botanicus/status/608688091776360449" class=
    "tweet-timestamp js-permalink js-nav js-tooltip" title=
    "6:32 PM - 10 Jun 2015"><span class=
    "_timestamp js-short-timestamp js-relative-timestamp" data-time="1433957524"
    data-time-ms="1433957524000" data-long-form="true" aria-hidden=
    "true">3h</span><span class="u-hiddenVisually" data-aria-label-part="last">3 hours
    ago</span></a></small>
  </div>

  <p class="TweetTextSize js-tweet-text tweet-text" lang="en" data-aria-label-part="0"
  xml:lang="en">And I'm looking for a <a href="/hashtag/contract?src=hash"
  data-query-source="hashtag_click" class="twitter-hashtag pretty-link js-nav" dir=
  "ltr"><s>#</s><b><strong>contract</strong></b></a> <a href="http://t.co/sBkmEIw3kb"
  rel="nofollow" dir="ltr" data-expanded-url="http://buff.ly/1B3M4KX" class=
  "twitter-timeline-link" target="_blank" title="http://buff.ly/1B3M4KX"><span class=
  "invisible">http://</span><span class=
  "js-display-url">buff.ly/1B3M4KX</span><span class="tco-ellipsis"><span class=
  "invisible">&nbsp;</span></span></a>. Do you know about anyone who's hiring? RT
  please :) <a href="/hashtag/ruby?src=hash" data-query-source="hashtag_click" class=
  "twitter-hashtag pretty-link js-nav" dir=
  "ltr"><s>#</s><b><strong>ruby</strong></b></a> <a href="/hashtag/javascript?src=hash"
  data-query-source="hashtag_click" class="twitter-hashtag pretty-link js-nav" dir=
  "ltr"><s>#</s><b><strong>javascript</strong></b></a> <a href=
  "/hashtag/london?src=hash" data-query-source="hashtag_click" class=
  "twitter-hashtag pretty-link js-nav" dir="ltr"><s>#</s><b>london</b></a> <a href=
  "/hashtag/jobs?src=hash" data-query-source="hashtag_click" class=
  "twitter-hashtag pretty-link js-nav" dir="ltr"><s>#</s><b>jobs</b></a></p>

  <div class="expanded-content js-tweet-details-dropdown"></div>

  <div class="stream-item-footer">
    <span class="ProfileTweet-action--retweet u-hiddenVisually"><span class=
    "ProfileTweet-actionCount" data-tweet-stat-count="4"><span class=
    "ProfileTweet-actionCountForAria" data-aria-label-part="">4
    retweets</span></span></span> <span class=
    "ProfileTweet-action--favorite u-hiddenVisually"><span class=
    "ProfileTweet-actionCount" data-tweet-stat-count="1"><span class=
    "ProfileTweet-actionCountForAria" data-aria-label-part="">1
    favorite</span></span></span>

    <div role="group" aria-label="Tweet actions" class=
    "ProfileTweet-actionList u-cf js-actions pocket-inserted buffer-inserted">
      <div class="ProfileTweet-action ProfileTweet-action--reply">
        <button class=
        "ProfileTweet-actionButton u-textUserColorHover js-actionButton js-actionReply js-tooltip"
        data-modal="ProfileTweet-reply" type="button" title="Reply"><span class=
        "u-hiddenVisually">Reply</span></button>
      </div>

      <div class=
      "ProfileTweet-action ProfileTweet-action--retweet js-toggleState js-toggleRt">
        <button class=
        "ProfileTweet-actionButton is-disabled js-disableTweetAction js-actionButton js-actionRetweet js-tooltip"
        disabled="disabled" data-modal="ProfileTweet-retweet" type=
        "button"><span class="u-hiddenVisually">Retweet</span> <span class=
        "ProfileTweet-actionCount"><span class=
        "ProfileTweet-actionCountForPresentation" aria-hidden=
        "true">4</span></span></button> <button class=
        "ProfileTweet-actionButtonUndo js-actionButton js-actionRetweet js-tooltip"
        data-modal="ProfileTweet-retweet" title="Undo retweet" type="button">
        <span class="u-hiddenVisually">Retweeted</span> <span class=
        "ProfileTweet-actionCount"><span class=
        "ProfileTweet-actionCountForPresentation" aria-hidden=
        "true">4</span></span></button>
      </div>

      <div class="action-buffer-container">
        <a class="ProfileTweet-action js-tooltip" href="#" data-original-title=
        "Add to Buffer"></a>
      </div>

      <div class="action-pocket-container">
        <a class="ProfileTweet-action js-tooltip" href="#" data-original-title=
        "Save to Pocket"></a>
      </div>

      <div class="ProfileTweet-action ProfileTweet-action--favorite js-toggleState">
        <button class=
        "ProfileTweet-actionButton js-actionButton js-actionFavorite js-tooltip" title=
        "Favorite" type="button"><span class="u-hiddenVisually">Favorite</span>
        <span class="ProfileTweet-actionCount"><span class=
        "ProfileTweet-actionCountForPresentation" aria-hidden=
        "true">1</span></span></button> <button class=
        "ProfileTweet-actionButtonUndo u-linkClean js-actionButton js-actionFavorite js-tooltip"
        title="Undo favorite" type="button"> <span class=
        "u-hiddenVisually">Favorited</span> <span class=
        "ProfileTweet-actionCount"><span class=
        "ProfileTweet-actionCountForPresentation" aria-hidden=
        "true">1</span></span></button>
      </div>

      <div class=
      "ProfileTweet-action ProfileTweet-action--more js-more-ProfileTweet-actions">
        <div class="dropdown">
          <button class=
          "ProfileTweet-actionButton u-textUserColorHover dropdown-toggle js-tooltip js-dropdown-toggle"
          type="button" title="More"><span class=
          "u-hiddenVisually">More</span></button>

          <div class="dropdown-menu">
            <div class="dropdown-caret">
              <div class="caret-outer"></div>

              <div class="caret-inner"></div>
            </div>

            <ul>
              <li class="share-via-dm js-actionShareViaDM" data-nav="share_tweet_dm">
              <button type="button" class="dropdown-link">Share via Direct
              Message</button></li>

              <li class="copy-link-to-tweet js-actionCopyLinkToTweet"><button type=
              "button" class="dropdown-link">Copy link to Tweet</button></li>

              <li class="embed-link js-actionEmbedTweet" data-nav="embed_tweet">
              <button type="button" class="dropdown-link">Embed Tweet</button></li>

              <li class="user-pin-tweet js-actionPinTweet" data-nav="user_pin_tweet">
              <button type="button" class="dropdown-link">Pin to your profile
              page</button></li>

              <li class="user-unpin-tweet js-actionPinTweet" data-nav=
              "user_unpin_tweet"><button type="button" class="dropdown-link">Unpin from
              profile page</button></li>

              <li class="js-actionDelete"><button type="button" class=
              "dropdown-link">Delete Tweet</button></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
