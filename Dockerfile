# Step 1: Set up the base image for Ruby and Node.js (with Yarn 1.22.22)
FROM ruby:3.1.2 AS base

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get update -qq \
    && apt-get install -y nodejs \
    && npm install -g yarn@1.22.22

# Step 2: Set up the application directory
WORKDIR /rails

# Step 3: Copy the Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Step 4: Copy the rest of the application code
COPY . ./

# Step 5: Install Yarn dependencies
RUN yarn install --frozen-lockfile

# Step 6: Install missing dependencies (webpack, babel-related, etc.)
RUN yarn add @babel/core webpack-assets-manifest webpack-merge babel-loader compression-webpack-plugin terser-webpack-plugin

# Step 7: Precompile assets (using a dummy key for SECRET_KEY_BASE)
RUN SECRET_KEY_BASE=dummy_key bundle exec rails assets:precompile

# Step 8: Clean up temporary files if needed
RUN rm -rf tmp/cache

# Final Stage for the app image
FROM base AS final

# Step 9: Expose the port (adjust as necessary)
EXPOSE 3000

# Step 10: Set the entrypoint to start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
