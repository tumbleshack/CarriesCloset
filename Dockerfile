FROM ruby:2.7.0
RUN apt-get update -qq

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /cc_server

COPY Gemfile /cc_server/Gemfile
COPY Gemfile.lock /cc_server/Gemfile.lock
RUN bundle install && gem install bundler:2.2.1

COPY package.json /cc_server/package.json
COPY yarn.lock /cc_server/yarn.lock
RUN yarn install --check-files

COPY . /cc_server

# Start the main process.
CMD rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'