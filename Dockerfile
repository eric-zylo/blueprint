# Step 1: Use a Ruby image that includes Ruby 3.2.0 or higher
FROM ruby:3.2.0

# Step 2: Install dependencies (Node.js, Yarn)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get update -y \
    && apt-get install -y nodejs postgresql-client

# Step 3: Install Yarn
RUN npm install -g yarn@1.22.22

# Step 4: Set up working directory
WORKDIR /rails

# Step 5: Copy Gemfile and install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Step 6: Copy the rest of the application code
COPY . .

# Step 7: Precompile assets
RUN SECRET_KEY_BASE=dummy_key bundle exec rails assets:precompile

# Step 8: Expose the necessary port
EXPOSE 3000

# Step 9: Start the Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
