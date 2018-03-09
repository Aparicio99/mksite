dnl URL for files other than pages like CSS or images
define(`BASEURL', `__BASE_URL__/$1')dnl
dnl Absolute page URL
define(`LINK', `__BASE_URL__/$1`'__EXT__')dnl
dnl Absolute page URL for alternate theme
define(`OTHER_THEME_LINK', `__OTHER_THEME_URL__/$1`'__EXT__')dnl
dnl Relative page URL
define(`RELLINK', `$1`'__EXT__')dnl
dnl URL to directory with an index file
define(`INDEX', `ifelse(__EXT__, `', `__BASE_URL__/$1/', `__BASE_URL__/$1/index`'__EXT__')')dnl
dnl Homepage URL
define(`__HOMEPAGE__', `ifelse(__EXT__, `', `__BASE_URL__/__EXT__', `__BASE_URL__/index`'__EXT__')')dnl
