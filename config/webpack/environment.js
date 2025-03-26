const { environment } = require('@rails/webpacker');
const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin');

environment.loaders.append('babel', {
  test: /\.(js|jsx)$/,
  use: 'babel-loader',
  exclude: /node_modules/,
});

if (process.env.NODE_ENV === 'development') {
  environment.plugins.append(
    'reactRefresh',
    new ReactRefreshWebpackPlugin()
  );
}

module.exports = environment;
