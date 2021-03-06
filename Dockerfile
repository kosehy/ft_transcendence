FROM ruby:2.6.3-alpine

RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata

RUN mkdir /project
WORKDIR /project

COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3
RUN yarn add bootstrap jquery popper.js

COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]