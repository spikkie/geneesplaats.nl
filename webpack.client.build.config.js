const path = require("path");
const { ReactLoadablePlugin } = require('react-loadable/webpack');
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const buildDirectory = "dist";
const outputDirectory = buildDirectory + "/client";

module.exports = {
    mode: "production",
    entry: "./src/client/index.js",
    output: {
        path: path.join(__dirname, outputDirectory),
      filename: "bundle.js",
      publicPath: '/',
      chunkFilename: '[name].[chunkhash].js'
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: { loader: "babel-loader" }
            },
            {
                test: /\.css$/,
                use: [
                    {
                        loader: MiniCssExtractPlugin.loader,
                        options: { publicPath: "../" }
                    },
                    "css-loader"
                ]
            }
        ]
    },
    plugins: [
        //new CleanWebpackPlugin([buildDirectory]),
            new CleanWebpackPlugin({
                // Simulate the removal of files
                //
                // default: false
                dry: true,

                // Write Logs to Console
                // (Always enabled when dry is true)
                //
                // default: false
                verbose: true,

                // Automatically remove all unused webpack assets on rebuild
                //
                // default: true
                cleanStaleWebpackAssets: false,

                // Do not allow removal of current webpack assets
                //
                // default: true
                protectWebpackAssets: false,

                // **WARNING**
                //
                // Notes for the below options:
                //
                // They are unsafe...so test initially with dry: true.
                //
                // Relative to webpack's output.path directory.
                // If outside of webpack's output.path directory,
                //    use full path. path.join(process.cwd(), 'build/**/*')
                //
                // These options extend del's pattern matching API.
                // See https://github.com/sindresorhus/del#patterns
                //    for pattern matching documentation

                // Removes files once prior to Webpack compilation
                //   Not included in rebuilds (watch mode)
                //
                // Use !negative patterns to exclude files
                //
                // default: ['**/*']
                cleanOnceBeforeBuildPatterns: ["**/*", "!static-files*"],
                cleanOnceBeforeBuildPatterns: [], // disables cleanOnceBeforeBuildPatterns

                // Removes files after every build (including watch mode) that match this pattern.
                // Used for files that are not created directly by Webpack.
                //
                // Use !negative patterns to exclude files
                //
                // default: []
                cleanAfterEveryBuildPatterns: ["static*.*", "!static1.js"],

                // Allow clean patterns outside of process.cwd()
                //
                // requires dry option to be explicitly set
                //
                // default: false
                dangerouslyAllowCleanPatternsOutsideProject: true
            }),        

            new ReactLoadablePlugin({
        filename: './dist/react-loadable.json',
      }),  
        new MiniCssExtractPlugin({
            filename: 'bundle.css',
        })
    ]
};
