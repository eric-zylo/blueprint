# syntax=docker/dockerfile:1
# check=error=true

# Use correct Ruby version
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install base dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test" \
    PORT=10000

# Build dependencies
FROM base AS build

# Install necessary build tools
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config nodejs yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code (moved up before yarn install)
COPY . .

# Ensure Yarn dependencies install correctly
RUN yarn install

# Ensure database configuration is in place (Render provides DATABASE_URL)
RUN rm -f config/database.yml && \
    echo "production:\n  adapter: postgresql\n  url: <%= ENV['DATABASE_URL'] %>" > config/database.yml

# Precompile assets
RUN SECRET_KEY_BASE=dummy_key bundle exec rails assets:precompile

# Final stage for the app image
FROM base

# Copy built application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Ensure correct file permissions
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp node_modules
USER 1000:1000

# Expose correct port for Render
EXPOSE 10000

# Start server in production mode
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "10000", "-e", "production"]
