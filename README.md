chuck.vim
=========
This is a rewrite of Andy Wilsons [Plug-In](https://github.com/wilsaj/chuck.vim).
This version doesn't start ChucK in Vim but adds a way to remove or replace shreds and doesn't depend on vimproc.

Currently supports syntax highlighting,and controling the Chuck VM(e.g. starting/stopping shreds).

installation
------------
This plugin doesn't have any prerequisits.
Install with any Plug-in manager or you can also copy the files manually.

usage
------------
Open chuck in another terminal window in the same directory in loop mode (chuck --loop).
Open all files in different buffers (not new instances of vim!). (e.g. :tabnew file2.ck)
The following functions can be used to interact with the Chuck VM:

\+   save and add current buffer <br/>
\-   remove last added shred <br/>
\=   save buffer and replace last added shred <br/>
<br/>
\@   remove selected shred <br/>
\#   save buffer and replace selected shred <br/>
<br/>
\_  remove all shreds <br/>
\*  add all open buffers <br/>
<br/>
\^  status


