FROM ruby:2.2.2-slim

ENV ROOT /apps/contract-hunt

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $ROOT
WORKDIR $ROOT

ADD Gemfile Gemfile.lock vendor/cache $ROOT/
RUN bundle install --without development --deployment

VOLUME ["/data"]

ADD . $ROOT

CMD ["/usr/local/bin/bundle", "exec", "./bin/scheduler.rb", "/data"]
