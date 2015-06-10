#!/usr/bin/env ruby

# Docker can run only one process.

require 'timeout'

unless ARGV.length == 1
  abort "You have to provide the command to run as the first argument!"
end

command = ARGV.first

def run(command)
  puts "~ [#{Time.now.utc.strftime('%Y/%m/%d %H:%M')}] Wakey, wakey!"
  puts "$ #{command}"
  begin
    body = Timeout.timeout(120) { system command }
  rescue Timeout::Error
    number_of_tries ||= 0
    number_of_tries += 1
    if number_of_tries > 3
      abort "! Generating the digest timed out!"
    else
      puts "~ Time out, retrying."
      retry
    end
  end
end

n = Time.now.utc
# next_digest_time = Time.new(n.year, n.month, n.day + 1, 6, 20, 0, '+00:00').utc
next_digest_time = Time.new(n.year, n.month, n.day, n.hour, n.min, n.sec + 1, '+00:00').utc

puts "~ Scheduler waiting until #{next_digest_time} (#{next_digest_time - n} sec)."
sleep next_digest_time - n
run(command)

loop do
  sleep 24 * 60 * 60
  run(command)
end
