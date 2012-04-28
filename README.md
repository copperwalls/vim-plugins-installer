vim-plugins-installer
=====================

Install (and update) your [Vim](http://vim.org/) plugins super easily.

If [pathogen.vim](https://github.com/tpope/vim-pathogen) “makes it super easy to install plugins and runtime files in their own private directories”, this script will make everything—including installing pathogen.vim itself and updating the plugins—even easier.

In other words: I’m lazy and I don’t have time. If I can automate it, I will :)

Requirements
------------

[Git](http://git-scm.com/) is used for plugin (source code) management. Therefore, this will work on any OS with Vim and Git installed. (e.g. [Mac OS X](http://www.apple.com/macosx/), GNU/Linux) This will probably work on Windows too (inside [Cygwin](http://cygwin.com/)) but I don’t usually use and won’t recommend Windows ;)

How
---

Just clone/download the files then run the installer:

    ./install-vim-plugins.sh

That script will:
-----------------

1. Download and install the excellent pathogen.vim plugin
2. Download and install other plugins you enumerated in plugins.urls
3. Create a ~/.vimrc file if it doesn’t exist
4. Create a ~/.vim directory if it doesn’t exist
5. Make your life easier

NOTE: The installer will create a new ~/.vim directory if the pathogen.vim file is not found. If there was ~/.vim directory it will be renamed in the following format: ~/.vim-old-`date +%s`

Read the source code (of course!) for more details.

Included files
--------------

- install-vim-plugins.sh — The installer (Bash script)
- plugins.urls — Sample file; replace with your own (or use as it is)
- dotvimrc — Sample file; replace with your own (or use as it is)
- README.md — This very document
- MIT-License.txt — License file (Contents also found at end of this document)

Notes
-----

Updating the plugins is very easy. There are at least three different ways.

1. Delete the ~/.vim directory and run the script again. (This is slow, inefficient, and wasteful use of internet resources.)
2. Run the appropriate git commands. (This is faster and more efficient but troublesome.)
3. Just use the companion ([vim-plugins-updater](https://github.com/copperwalls/vim-plugins-updater)) script. (Fastest and easiest way. For lazy people like me.)

NOTE in Notes: Obviously, only the first one can update pathogen itself. If you go for the last one, just update pathogen manually:

    curl -so ~/.vim/autoload/pathogen.vim \
        https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

or

    wget -O ~/.vim/autoload/pathogen.vim \
        https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

TODO
----

Decide if it’s a good idea to put pathogen.vim inside ~/.vim/bundle together with all the other plugins.

Contributing
------------

It’s a small script. I’m sure there’s a big room for improvement. If you can improve it, I encourage you to do so. Of course, you don’t have to get your hands dirty. If you have an idea, just let me know. If I see fit to add it, I’ll even write the code myself.

License
-------

Copyright (c) 2012 ed.o

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

