FROM ruby:2.2.2-slim

ENV ROOT /apps/contract-hunt

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $ROOT
ADD . $ROOT

RUN cd $ROOT && bundle install --without development

CMD ["$ROOT/bin/scheduler.rb"]
