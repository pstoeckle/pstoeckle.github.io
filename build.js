const fs = require('fs');
const htmlMinifier = require('html-minifier');
const logError = (err2) => {
    if (err2) {
        console.error(err2);
        return;
    }
}

fs.readFile('_site/index.html', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    const result = htmlMinifier.minify(data, {
        minifyCSS: true,
        collapseWhitespace: true,
        removeComments: true
    });
    fs.writeFile('_site/index.html', result, {},logError )
})

fs.rm('_site/LICENSE', logError)
fs.rm('_site/README.md', logError)
fs.rm('_site/build.js', logError)
fs.rm('_site/CODEOWNERS', logError)
fs.rm('_site/package.json', (_) =>{})
fs.rm('_site/package-lock.json', (_) =>{})
