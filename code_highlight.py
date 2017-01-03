#!/usr/bin/env python3
import sys
from bs4 import BeautifulSoup
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

formatter = HtmlFormatter(linenos=False, style="molokai")

#from pygments.styles import get_style_by_name
#print(formatter.get_style_defs())

soup = BeautifulSoup(sys.stdin, "html.parser")
nodes = soup.select('pre')

for node in nodes:
	try:
		code_tag = node.code
		try:
			class_name = code_tag['class'][0]
			language = class_name.replace('language-', '')
		except:
			language = "text"

		code = node.string
		lexer = get_lexer_by_name(language, stripnl=False)

		highlighted_code = highlight(code, lexer, formatter)

		node.replaceWith(BeautifulSoup(highlighted_code, "html.parser"))
	except:
		pass

print(soup)
