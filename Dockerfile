FROM ruby:2.7.0
RUN apt-get update -qq && \
  apt-get install -y build-essential \ 
  libpq-dev \
  nodejs
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
  apt-get install nodejs
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn
RUN mkdir /portfolioec
ENV APP_ROOT /portfolioec
WORKDIR $APP_ROOT
COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install
COPY . $APP_ROOT