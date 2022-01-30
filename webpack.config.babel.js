import webpack from 'webpack';
import WebpackNotifierPlugin from 'webpack-notifier';
import path from 'path';

const COMPONENTS_PATH = path.join(__dirname, 'app/assets/javascripts/app');
// app entry file (used for webpack only)
const APP_ENTRY_FILE = './global.js';
// bundle path (JavaScripts root)
const OUTPUT_PATH = path.join(__dirname, 'app/assets/javascripts/');
// bundle (rails assets file)
const OUTPUT_FILE = 'bundle.js';

const env = process.env.NODE_ENV || 'development';

// const autoprefixer = require('autoprefixer');

const ProvidePlugin = require('webpack/lib/ProvidePlugin');

// postcss: [autoprefixer]; // this is inside module.exports object

export default {
  context: COMPONENTS_PATH,
  entry: {
    app: [APP_ENTRY_FILE]
  },
  output: {
    path: OUTPUT_PATH,
    filename: OUTPUT_FILE
  },
  devtool: 'source-map',
  module: {
    rules: [
      { 
        test: /\.js?$/,         // Match both .js and .jsx files
        exclude: /node_modules/, 
        loader: "babel", 
      }
    ],
    rules: [{
      test: /\.jsx?$/,         // Match both .js and .jsx files
      exclude: /node_modules/,
      use: ['babel-loader']
    },
    ]
  },
  resolve: {
    extensions: [
      '.jsx',
      '.js'
    ],
    modules: [
      COMPONENTS_PATH,
      "node_modules"
    ]
  },
  plugins: [
    new webpack.NoEmitOnErrorsPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify(env)
      }
    }),
    new WebpackNotifierPlugin(),
    new webpack.ProvidePlugin({
    }),
  ]
};
