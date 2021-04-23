#!/bin/bash
bundle exec rake db:migrate

> log/production.log
rm -f tmp/pids/server.pid

bundle exec rails server -e production -b '0.0.0.0' -p $PORT