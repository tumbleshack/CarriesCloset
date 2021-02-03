FROM ruby:2.7.2

# Unimportant Container configuration
RUN apt-get update -qq
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Transfer ownership away from root (bad) to dedicated rails_user (good).
WORKDIR /cc_server
RUN useradd -ms /bin/bash rails_user
RUN chown -R rails_user:rails_user /cc_server
RUN chmod 755 /cc_server
USER rails_user

# Install all dependencies through `gem` and `yarn` package managers.
COPY --chown=rails_user:rails_user Gemfile /cc_server/Gemfile
COPY --chown=rails_user:rails_user Gemfile.lock /cc_server/Gemfile.lock
RUN gem install bundler:2.2.8 && bundle install

COPY --chown=rails_user:rails_user package.json /cc_server/package.json
COPY --chown=rails_user:rails_user yarn.lock /cc_server/yarn.lock
RUN yarn install --check-files

# Copy all remaining local files into container
COPY . /cc_server

# Expose ports for access either from `dev` (:3000) or `prod` (:80 and :443)
EXPOSE 3000
EXPOSE 443
EXPOSE 80

# Start the main process.
CMD rm -f tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0'
