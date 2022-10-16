FROM ruby:2.7.6 AS builder

RUN gem install bundler:2.2.14
COPY Gemfile* ./
RUN bundle install

FROM ruby:2.7.6 AS runner
WORKDIR /usr/src/app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . .

EXPOSE 3000
CMD ["bash"]