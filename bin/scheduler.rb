#!/usr/bin/env ruby

# Docker can run only one process.

unless ARGV.length == 1
  abort "You have to provide the command to run as the first argument!"
end

command = ARGV.first

def run(command)
  puts "~ [#{Time.now.utc.strftime('%Y/%m/%d %H:%M')}] Wakey, wakey!"
  puts "$ #{command}"
  system command
end

n = Time.now.utc
# next_digest_time = Time.new(n.year, n.month, n.day + 1, 6, 20, 0, 0)
next_digest_time = Time.new(n.year, n.month, n.day + 1, 16, 40, 0, 1)

puts "~ Scheduler waiting until #{next_digest_time}."
sleep next_digest_time - Time.now.utc
run(command)

loop do
  sleep 24 * 60 * 60
  run(command)
end
