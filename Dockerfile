# Step 1: Use Ruby as base
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install base dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client nodejs yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Step 2: Install build dependencies (for compiling assets and gems)
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config \
    libreadline-dev ruby-dev libjemalloc2 libvips postgresql-client nodejs yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --deployment --without development test --verbose

# Ensure .bundle directory exists
RUN mkdir -p /rails/.bundle

# Copy application code
COPY . .

# Set correct working directory
WORKDIR /rails

# Debug step to verify the correct directory and files
RUN ls -la /rails

# Step 3: Install Yarn dependencies
FROM node:14

# Set working directory
WORKDIR /app

# Install dependencies and Yarn
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn@1.22.22

# Install project dependencies
RUN yarn install

# Step 4: Ensure database configuration
RUN rm -f config/database.yml && \
    echo "production:\n  adapter: postgresql\n  url: <%= ENV['DATABASE_URL'] %>" > config/database.yml

# Step 5: Precompile assets
RUN SECRET_KEY_BASE=dummy_key bundle exec rails assets:precompile

# Final Stage for the app image
FROM base

# Copy over the build
COPY --from=build /rails /rails
COPY --from=build /rails/.bundle /rails/.bundle

# Install gems in production
RUN bundle install --deployment --without development test

# Expose correct port for Render
EXPOSE 10000

# Set up permissions and user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p /rails/db /rails/log /rails/storage /rails/tmp && \
    chown -R rails:rails /rails
USER 1000:1000

# Start server in production mode
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "10000", "-e", "production"]
