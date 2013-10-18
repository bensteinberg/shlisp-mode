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

M-s sends the current file to the shnth.  The shlisp application has to be in your $PATH.  OS checking has not been tested, except on a Mac.

See also:

* http://shbobo.net/
