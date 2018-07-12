// webpack.config.js
var Encore = require('@symfony/webpack-encore');

var CopyWebpackPlugin = require('copy-webpack-plugin');

var ImageminPlugin = require('imagemin-webpack-plugin').default;

Encore
// the project directory where all compiled assets will be stored
    .setOutputPath('dist/')

    // the public path used by the web server to access the previous directory
    .setPublicPath('/profiles/contrib/skeletor/themes/custom/barebones_bootstrap_STARTERKIT/dist')

    // will create dist/app.js and dist/app.css
    .addEntry('app', './src/js/app.js')

    // allow legacy applications to use $/jQuery as a global variable
    .autoProvidejQuery()

    // enable source maps during development
    .enableSourceMaps(!Encore.isProduction())

    // empty the outputPath dir before each build
    .cleanupOutputBeforeBuild()

    // show OS notifications when builds finish/fail
    .enableBuildNotifications()

// create hashed filenames (e.g. app.abc123.css)
// .enableVersioning()

// allow sass/scss files to be processed
    .enableSassLoader()

    .enablePostCssLoader()

    .addPlugin(new CopyWebpackPlugin([{
        from: 'src/images/',
        to: 'images/'
    }]))
    .addPlugin(new ImageminPlugin({ test: /\.(jpe?g|png|gif|svg)$/i }))
;

// export the final configuration
module.exports = Encore.getWebpackConfig();