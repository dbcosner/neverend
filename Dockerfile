FROM ruby:3.3.0 as  base

# Rails installation dependencies:
RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

# Create the working directory inside the container:
WORKDIR /docker/app

RUN gem install bundler

# Copy Gemfile and Gemfile.lock from the directory containing this Dockerfile to the container's working directory:
COPY Gemfile* ./

RUN bundle install

# Copy AND DECOMPRESS the files in the directory containing this file and its subdirectories:
ADD . /docker/app

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD ["rails","server"]
