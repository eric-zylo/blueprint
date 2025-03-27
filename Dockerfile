# Step 1: Use Ruby as base
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install base dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Yarn globally (for Yarn 1.x)
RUN npm install -g yarn@1.22.22

# Step 2: Install build dependencies (for compiling assets and gems)
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config nodejs && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Step 3: Install Yarn dependencies
# Copy application code
COPY . .

# Set correct working directory
WORKDIR /rails

# Debug step to verify the correct directory and files
RUN ls -la /rails

# Ensure Yarn dependencies install correctly
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
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"

# Expose correct port for Render
EXPOSE 10000

# Set up permissions and user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

# Start server in production mode
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "10000", "-e", "production"]
