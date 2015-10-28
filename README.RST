VIM BOX
=======

PERSONAL VIM BOX

Set up vimrc
------------

::

 " encodings setup
 set ff=unix
 set encoding=utf-8
 set termencoding=utf-8
 set fileencoding=utf-8
 set fileencodings=ucs-bom,utf-8,chinese,cp936
 scriptencoding utf-8
 " language messages zh_CN.utf-8
 language messages en_US.utf-8

 " source your vim-box vimrc
 so ~/Dropbox/vim-box/vimrc

Install plug
------------

https://github.com/junegunn/vim-plug
::

   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ 
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
