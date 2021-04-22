#!/bin/bash

bundle exec rake db:create

bundle exec rake db:migrate db:seed

> log/production.log
rm -f tmp/pids/server.pid


bundle exec rails server -e production -b '0.0.0.0' -p $PORT