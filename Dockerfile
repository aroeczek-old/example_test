FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /gat
WORKDIR /gat
COPY Gemfile /gat/Gemfile

RUN bundle install
COPY . /gat

EXPOSE 3000
