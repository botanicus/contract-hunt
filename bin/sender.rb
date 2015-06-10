#!/usr/bin/env ruby

require 'pony'
require 'timeout'

begin
  body = Timeout.timeout(60) { STDIN.read }
rescue Timeout::Error
  abort "! Generating the digest timed out!"
end

Pony.mail({
  to: 'contracts@101ideas.cz',
  subject: 'Contract digest',
  from: 'james@botanicus.me',
  html_body: body,
  via: :smtp,
  # Provided by EasySMTP.
  via_options: {
    address: 'ssrs.reachmail.net',
    port: '25',
    user_name: 'JAMESCRU1\admin',
    password: 'C@82@zCM',
    authentication: :plain,
  }
})
