FROM ruby:2.6.3-alpine3.9

ENV APP_HOME /graphql-tutorial

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update bash \
                                build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                tzdata \
                                vim


# Install Yarn
ENV PATH=/root/.yarn/bin:$PATH
RUN apk add --virtual build-yarn curl && \
    touch ~/.bashrc && \
    curl -o- -L https://yarnpkg.com/install.sh | sh && \
    apk del build-yarn

# Create a directory for our application
# and set it as the working directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add our Gemfile and install gems
RUN gem install bundler
ADD Gemfile* $APP_HOME/
RUN bundle install

# Copy over our application code
ADD . $APP_HOME

# Make yarn (Rails) happy
RUN yarn install --check-files

# Run our app
# When there is a DB - bundle exec rails db:create db:migrate db:seed &&
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails s -p ${PORT} -b '0.0.0.0'
