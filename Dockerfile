FROM ruby:2.7.7 
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler -v 2.3.5
RUN mkdir /app
WORKDIR /app 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app