#!/bin/sh

echo "~ Starting the service."
bundle exec bin/scheduler.rb "bundle exec bin/contract-hunt.rb /data | bundle exec bin/sender.rb"
