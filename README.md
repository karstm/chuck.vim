chuck.vim
=========

A vim plugin for [ChucK](http://chuck.stanford.edu/), a programming language for
real-time sound synthesis and music creation. Currently supports syntax highlighting,
and controling the Chuck VM(e.g. starting/stopping shreds).

installation
------------

This plugin depends on [vimproc](https://github.com/Shougo/vimproc.vim) for controlling the Chuck VM.

Install with any Plug-in manager or you can also copy the files manually to their corresponding directories in
your `~/.vim/` directory if you're into the taste of awfulness.

usage
------------
Open chuck in another terminal window in loop mode (chuck --loop).
Open all files in different buffers not new instances of vim. (e.g. :tabnew then :e file2.ck)
The following functions can be used to interact with the Chuck VM:

\+   add current buffer <br/>
\-   remove last added shred <br/>
\=   replace last added shred <br/>
<br/>
\@   select shred no. <br/>
\#   remove selected shred <br/>
\$   remove selected shred <br/>
<br/>
\_  remove all shreds <br/>
\*  add all open buffers <br/>
<br/>
\^  status


