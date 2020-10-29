FROM ruby:2.6.5

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client

WORKDIR /app

ADD Gemfile .
ADD Gemfile.lock .
RUN gem install bunlder && bundle install -j4 && bundle update

ADD . /app

WORKDIR .

EXPOSE 3000
