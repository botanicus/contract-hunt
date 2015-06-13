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

# Run immediately
# Set RUN_IMMEDIATELY_ONCE and restart the service.
run(command) if ENV['RUN_IMMEDIATELY_ONCE']

n = Time.now.utc
next_digest_time = Time.new(n.year, n.month, n.day, 6, 20, 0, '+01:00').utc
next_digest_time += 24 * 60 * 60 if next_digest_time < n

puts "~ Scheduler waiting until #{next_digest_time} (#{next_digest_time - n} sec)."
STDOUT.flush # Otherwise you can forget to see the log message until the sleep has finished. LOL.

sleep next_digest_time - n
run(command)

loop do
  sleep 24 * 60 * 60
  run(command)
end
