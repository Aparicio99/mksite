/* global styling */

p, li, td, th {
	line-height: 1.5em;
}

/* page layout */

/* margin/padding: top/bottom right/left */
/* margin/padding: top right/left bottom */
/* margin/padding: top right bottom left */

body {
	font: normal 0.9em Verdana, Arial, Helvetica, sans-serif;
	color: TEXT;
	text-align: left;
	background: BG none repeat scroll 0 0;
	margin: 0 10pt 0;
}

#page {
	margin: 0 auto;
	width: 890px;
}

#content {
	border: 1px solid CONTENT_BORDER;
	text-align: left;
	background-color: CONTENT_BG;
	padding: 30px;
	clear: both;
}

/* Header */

#header {
	padding: 30px 30px 20px;
}

#header h1 {
	font-size: 16pt;
	margin: 0;
}

#header a {
	color: PAGE_TITLE;
}

/* Footer */

#footer {
	font-size: 0.7em;
	color: FOOTER_FG;
	letter-spacing: 0.1em;
	padding: 0 30px 60px;
	line-height: 2.0em;
}

#footer a {
	color: FOOTER_LINK;
}

#footer a:hover, #footer a:active {
	color: LINK_HOVER;
}

/***** HTML tags styling *****/

/* Headers */

h1, h2, h3, h4, h5, h6 {
	color: HEADER;
	margin: 1em 0 0;
	padding: 0;
}

#content h1 {
	font-size: 2.5em;
	font-weight: normal;
	margin-top: 0;
}

#content h2 {
	font-size: 2.1em;
	font-weight: normal;
}

#content h3 {
	font-size: 1.6em;
	font-weight: normal;
}

#content h4 {
	font-size: 1.2em;
	font-weight: bold;
	letter-spacing: 0.1em;
}

#content h5 {
	font-size: 1.1em;
	font-weight: bold;
	letter-spacing: 0.2em;
}

#content h6 {
	font-size: 1.0em;
	font-weight: bold;
	letter-spacing: 0.1em;
}

/* Links */

a {
	color: LINK;
	text-decoration: none;
}

#content a:link, #content a:visited {
	color: LINK;
}

#content a:hover, #content a:active {
	color: LINK_HOVER;
}

/* Lists */

ul, ol {
	padding: 0;
	margin-left: 1.8em;
}

li, dt, dd {
	line-height: 1.7em;
}

ul li {
	list-style: outside none square;
}

ul.sitemap li:hover {
	font-weight: bold;
}

/* Definition Lists */

dt {
	font-weight: bold;
}

dl.horizontal dt {
	float: left;
	overflow: hidden;
	text-align: right;
	text-overflow: ellipsis;
	white-space: nowrap;
}

dl.large dt { width: 160px; }
dl.large dd { margin-left: 180px; }
dl.small dt { width: 100px; }
dl.small dd { margin-left: 120px; }

/* Images */

img {
	border: 0px;
}

img.centre {
	display: block;
	text-align: center;
	margin: 5px auto;
}

img.center {
	display: block;
	text-align: center;
	margin: 5px auto;
}

img.left {
	margin: 5px 10px 5px 0;
	float: left;
}

img.right {
	margin: 5px 0 0px 10px;
	float: right;
}

img.icon {
	border: 0px;
	vertical-align: middle;
}

/* Other tags */

abbr {
	border-bottom: 1px dotted TEXT;
	cursor: help;
	color: TEXT;
}

blockquote {
	width: 75%;
	padding: 0 .5em;
	margin-left: 2em;
	border-left: 6px solid TABLE_BORDER;
}

hr {
	border: none 0;
	border-top: 1px solid HEADER;
}


pre {
	padding: 1em;
	font-size: 1.2em;
	/*-moz-tab-size: 4;
	-o-tab-size: 4;
	tab-size: 4;*/
}

code {
	background-color: CODE_BG;
	color: CODE_TEXT;
	font-family: Consolas, monospace;
	font-size: 0.85em;
	line-height: 1em;
	padding: .2em .5em;
	letter-spacing: 0.1em;
}

kbd {
	font-family: Consolas, monospace;
	font-size: 0.85em;
	border: 1px solid KBD_BORDER;
	padding: 0.1em 0.3em;
	border-radius: 0.2em;
}

/***** Content classes ******/

pre.cool {
	font-family: monospace;
	color: COOL;
	line-height: 20px;
	padding: 0;
}

pre.cool .string {
	color: COOLS;
}

.floatl {
	float: left;
	font-size: 90%;
	line-height: 1.5em;
	padding: 5px;
	width: 48%;
	margin-right: 3%;
	border: 1px dotted TABLE_BORDER;
}

.floatr {
	float: right;
	font-size: 90%;
	line-height: 1.5em;
	padding: 5px;
	width: 48%;
	margin-left: 3%;
	border: 1px dotted TABLE_BORDER;
}

.coolf {
	float: right;
	width: 48%;
}

.left {float:left;}

.right {float:right;}

.clear {clear:both;}

.underline {text-decoration: underline;}

.centre {text-align: center;}

.center, .center p {text-align: center;}

.smaller {font-size: smaller;}

.red {color: red;}
.green {color: green;}
.blue {color: blue;}
.orange {color: darkorange;}


/***** Tables *****/

table.data {
	border: 1px solid TABLE_BORDER;
	border-collapse: collapse;
	border-spacing: 0;
}

table.data caption {
	border: 1px solid TABLE_BORDER;
	font-size: 95%;
	color: HEADER;
	margin:5px 0;
	padding:2px;
	font-weight: bold;
}

table.data thead, table.data tfoot {
	background-color: THEAD_BG;
}

table.data th {
	border: 1px solid TABLE_BORDER;
	padding: .1em .25em;
}

table.data tbody tr {
	background-color: TR_BG;
}

table.data tbody tr:hover {
	background-color: TR_HOVER_BG;
}

table.data td {
	border: 1px solid TABLE_BORDER;
	padding: .1em .25em;
}

table.data td.number {
	text-align: right;
}

table.full {
	width: 100%;
}

table.mono {
	font-family: monospace;
	font-size: 1.2em;
}
