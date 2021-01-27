FROM ruby:2.7.0
RUN apt-get update -qq

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /cc_server
COPY Gemfile /cc_server/Gemfile
COPY Gemfile.lock /cc_server/Gemfile.lock
RUN bundle install
COPY . /cc_server

RUN yarn install --check-files

RUN bin/rails db:create
RUN bin/rails db:migrate
RUN bin/rails db:seed

# Start the main process.
CMD rails server -b 0.0.0.0