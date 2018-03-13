dnl URL for files other than pages like CSS or images
define(`BASEURL', `__BASE_URL__/$1')dnl

dnl Index page URL
define(`INDEX', `ifelse(__EXT__, `', `patsubst($1, `index$', `')', `$1`'__EXT__')')dnl

dnl Relative page URL
define(`LINK', `ifelse(regexp(`$1', `index$'), -1, $1`'__EXT__, INDEX($1))')dnl

dnl Absolute page URL
define(`PAGE', `__BASE_URL__/LINK($1)')dnl

dnl Absolute page URL for alternate theme
define(`ALTERNATE_PAGE', `__OTHER_THEME_URL__/LINK($1)')dnl

dnl Homepage URL
define(`__HOMEPAGE__', `PAGE(index)')dnl
