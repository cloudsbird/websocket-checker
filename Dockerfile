FROM ruby:3.1.2-slim

COPY . .

RUN gem install bundler
RUN bundle install

CMD bundle exec ruby app.rb