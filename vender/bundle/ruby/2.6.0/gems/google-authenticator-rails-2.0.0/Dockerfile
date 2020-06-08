FROM ruby:2.3.1

RUN mkdir -p /var/app

COPY Gemfile /var/app/Gemfile
COPY Gemfile.lock /var/app/Gemfile.lock
COPY google-authenticator.gemspec /var/app/google-authenticator.gemspec
COPY lib/google-authenticator-rails/version.rb /var/app/lib/google-authenticator-rails/version.rb
COPY Rakefile /var/app/Rakefile
COPY gemfiles/*.gemfile /var/app/
WORKDIR /var/app

RUN gem install bundler --version=1.15.4 --no-ri --no-rdoc

RUN bundle install
RUN bundle exec rake appraisal:install

