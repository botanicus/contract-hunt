FROM ruby:2.2.2-slim

ENV ROOT /apps/contract-hunt

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $ROOT
ADD Gemfile Gemfile.lock $ROOT/
RUN cd $ROOT && bundle install --without development

VOLUME ["/data"]

ADD . $ROOT

CMD [$ROOT/bin/scheduler.rb]
