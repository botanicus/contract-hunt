#!/usr/bin/env ruby

require 'pony'

Pony.mail({
  to: 'contracts@101ideas.cz',
  subject: 'Contract digest',
  from: 'james@botanicus.me',
  html_body: STDIN.read,
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
