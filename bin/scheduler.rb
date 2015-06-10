#!/usr/bin/env ruby

# Docker can run only one process.

def run
  puts "~ [#{Time.now.utc.strftime('%Y/%m/%d %H:%M')}] Wakey, wakey!"
  bin = File.expand_path('..', __FILE__)
  command = "bundle exec #{bin}/contract-hunt.rb | bundle exec #{bin}/sender.rb"
  puts "$ #{command}"
  system command
end

n = Time.now.utc
next_digest_time = Time.new(n.year, n.month, n.day + 1, 6, 20, 0, 0)

puts "~ Scheduler waiting until #{next_digest_time}."
sleep next_digest_time - Time.now.utc
run

loop do
  sleep 24 * 60 * 60
  run
end
