# mksite

Static site generator for creating simple sites with common Unix tools.

I created and develop it over time to mantain my [personal website](https://aparicio.pt),
not because there is no other tool with the same capabilities, but just for the sake of it,
and to have something that does exactly and only what I need.

It's complex but generates simple HTML.

## Features

  * Fully use Make dependency system
    * Only regenerates the needed files
    * Supports parallelism with `make -jX`
  * Generates pages based on the file extension
    * `.html` -> Copies HTML as is
    * `.md` -> Uses a markdown processor
    * `.sh/.awk/.py` -> Uses the script output
    * `.index` -> Generates a site map from the current directory
  * Generates page with the complete site map
  * Includes CSS minifier
  * Syntax highlighting for code blocks
  * Runs Make on the content directory to generate pages with dynamic content
    (like generating graphs with gnuplot from raw data)
  * Default template produces very lightweight pages with no Javascript (my [homepage](https://aparicio.pt) is 5.34 KB)

## Dependencies

The core dependencies are the following:

  * GNU **Make**
    * Coordinates everything
  * GNU **Awk**
    * Parsing and file generation
  * GNU **m4**
    * Macros for text replacement

This may work with Make or m4 other than the GNU ones, but was only tested with those.
Awk must really be Gawk since the scripts use Gawk specific extensions.

Optional dependencies:

  * **[cmark](https://github.com/commonmark/CommonMark)** or other markdown parser
    * To generate HTML from .md files
  * **python3-bs4** (BeautifulSoup)
  * **python3-pygments**
    * To generate syntax highlighted code

## How to use

Start by testing the example site locally on the browser.

```sh
$ git clone git@github.com:Aparicio99/mksite.git
$ cd mksite
$ echo "BASE_URL = $PWD/site" > config.mk
$ make
$ $BROWSER site/index.html
```

For a more personalized site hosted on a web server, override the other defaults on the file `config.mk`.

Example for a site to be served from `/var/www/webroot`, on the domain root, and with pretty
URLs without the `.html` extension:

```make
SITE = /var/www/webroot
CONTENT = content_dir
SITE_NAME = Your site name
SITE_DESCRIPTION = Your description
EXT =
BASE_URL =
```

To also generate a dark themed version of the site, also set:
```make
SITE_DARK = /var/www/webroot/dark
```

And put this on the Nginx configuration server section:

```nginx
index index.html;
try_files $uri $uri.html $uri/ =404;
error_page 404 /404.html;
error_page 403 /403.html;

```