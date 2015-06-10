#!/bin/sh

# ["/usr/local/bin/bundle", "exec", "./bin/scheduler.rb", "/usr/local/bin/bundle exec ./bin/contract-hunt.rb /data | /usr/local/bin/bundle exec ./bin/sender.rb"]
echo "~ Starting the service."
bundle exec bin/scheduler.rb "bundle exec bin/contract-hunt.rb /data | bundle exec bin/sender.rb"
