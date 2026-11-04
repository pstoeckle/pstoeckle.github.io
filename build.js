import fs from 'node:fs';
import { minify } from 'html-minifier';

const logError = (err2) => {
    if (err2) {
        console.error(err2);
        return;
    }
}

fs.readFile('_site/index.html', 'utf8', async (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    const result = await minify(data, {
        minifyCSS: true,
        collapseWhitespace: true,
        removeComments: true
    });
    fs.writeFile('_site/index.html', result, {},logError )
})
fs.readFile('_site/publications.html', 'utf8', async (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    const result = await minify(data, {
        minifyCSS: true,
        collapseWhitespace: true,
        removeComments: true
    });
    fs.writeFile('_site/publications.html', result, {},logError )
})

fs.mkdirSync('_site/.well-known/', { recursive: true });
fs.copyFile('.well-known/security.txt', '_site/.well-known/security.txt', logError)
fs.copyFile('.well-known/security.txt.asc', '_site/.well-known/security.txt.asc', logError)

fs.rm('_site/LICENSE', { force: true }, logError)
fs.rm('_site/README.md', { force: true }, logError)
fs.rm('_site/build.js', { force: true }, logError)
fs.rm('_site/CODEOWNERS', { force: true }, logError)
fs.rm('_site/package.json', (_) =>{})
fs.rm('_site/package-lock.json', (_) =>{})
