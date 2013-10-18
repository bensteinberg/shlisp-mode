shlisp-mode
===========
A derived major mode for the shlisp language, for GNU Emacs.  shlisp is the language of the shnth.

Put 
```
(load-file "/path/to/shlisp-mode.el")
```
 in your .emacs; you can invoke the mode by hand ("M-x shlisp-mode"), or it'll happen automatically for files with a .shlsp extension, as well as those with 
```
; -*-shlisp-*-
```
on the first line. 

M-s sends the current file to the shnth.  You might have to change the name of the shlisp program if you're not on a Mac; this is on my list of things to figure out.

See also:

* http://shbobo.net/
