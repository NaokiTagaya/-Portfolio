FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN mkdir /portfolioec
WORKDIR /portfolioec
COPY Gemfile /portfolioec/Gemfile
COPY Gemfile.lock /portfolioec/Gemfile.lock
RUN gem install bundler
RUN gem install bundler && bundle install
COPY . /portfolioec