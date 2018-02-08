--- header ---
title: Homepage
date: 21 Oct 2016
tags: structural
template: clean
--- body ---

![Image](BASEURL(files/smiles/awesome.png))

Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.

## H2 Title
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.

Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur adipisci[ng] velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut labore et dolore magnam aliquam quaerat voluptatem.

### H3 Title
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.

#### H4 Title
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.

##### H5 Title
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo.

###### H6 Title - markdown

Normal text.
**Bold text**.
*Italic text*.
`Inline code`.
[Homepage link](__HOMEPAGE__).

###### H6 Title - html tags

<ins>Ins</ins>.
<del>Del</del>.
<abbr title="Abbreviation">Abbr</abbr>.
<code>Inline code with tag</code>.

Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur adipisci[ng] velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut labore et dolore magnam aliquam quaerat voluptatem.

> Quote stuff here
> and here

Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur?

```scheme
(define (fact n)
  (if (zero? n) 1
	(* n (fact (- n 1)))))
```
And now C code.
```c
#include <stdio.h>
int main(int argc, char **argv) {
	printf("Hello world");
	return 0;
}
```

List of things:
 * Thing 1
 * Thing 2
 * Thing 3
   * Sub thing 3.1
   * Sub thing 3.2
     * Sub Sub thing 3.2.1
 * Thing 4

 1) isto
 2) aquilo
 3) aqueleoutro

Split below

---
Split above

<table class="data full">
  <caption>Tabela 1</caption>
  <thead>
   <tr><th>Oneeeeee</th><th>Twoooooooo</th><th>Threeeeeeee</th></tr>
  </thead>
  <tbody>
   <tr><td>One</td><td>Two</td><td>Three</td></tr>
   <tr><td>One</td><td>Two</td><td>Three</td></tr>
   <tr><th>Oneee</th><th>Twoooooo</th><th>Threeeeee</th></tr>
   <tr><td>One</td><td>Two</td><td>Three</td></tr>
   <tr><td>One</td><td>Two</td><td>Three</td></tr>
   <tr><td>One</td><td>Two</td><td>Three</td></tr>
  </tbody>
  <tfoot>
   <tr><td>One</td><td>Two</td><td>Three</td></tr>
  </tfoot>
</table>

```python
from this import that
import another_stuff

me = {
	'foo': 'bar',
}
```

<pre>
	pre pre
</pre>

<span class=floatr>Floating...</span></p>
Cenas

<kbd>Ctrl</kbd>+<kbd>A</kbd>
