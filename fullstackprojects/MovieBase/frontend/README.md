# Frontend Directory

## What is contained here:

In here we have the code for the frontend client for Moviebase. This includes all necessary javascript, html, assets, and dockerization
content.

## Where should things be added:

All code should be stored in /src with the following structure:

* root: Any code required for the root app.js client
* /css: ALL css style sheet files
    * styles.css contains all of the dtyles that are reused across all pages, this includes button style overwrites and any other overwrites that need to persist across all pages.
    * Naming convention for .css files is as follows `nameofpage.css` with `nameofpage` being replaced with the name of the .html file that it is meant for. 
    * All css files for specific pages requires the following import to ensure uniform styling:
        `@import './styles.css';`
* /images: All image assets required for pages.
    * Images should Ideally be of .svg in order to gaurantee proper scaling
    * Secondary preference is .png files in order to support any transparency required for images.
* /js: All javascript used for frontend HTML pages, of note no javascript used by the client app should be stored here.
    * `common.js` should be imported across all pages with the tag `type='module'`
    * naming convention is similar to the .css naming convention. `nameofpage.js` with `nameofpage` being replaced with the name of the .html file that it is meant for.
* /templates: All of the .html files for each page
    * The names of the corresponding .css and .js files are based on the names of these .html files so try to make them unique and descriptive enough so that we don't have any overlap.