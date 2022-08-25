# syntax=docker/dockerfile:1
FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /app
WORKDIR /app

COPY . /
# COPY Gemfile.lock /rails_6/Gemfile.lock

RUN apt install nano

RUN gem install bundler

RUN bundle install
# ADD . /rails_6

# Add a script to be executed every time the container starts.
EXPOSE 3000 5432

# Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]
