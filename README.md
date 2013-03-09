dot.emacs.d
============================================================================

わたくし、りひにーの .emacs.d/ です。


Settings
----------------------------------------------------------------------------

ディレクトリ構成はこのようになっています:

    ~/
      bin/
      site-lisp/
      site-started.d/

通常の Emacs Lisp パッケージは site-lisp/ に、その設定は site-start.d/ に入っています。  
submodule を使っているので、git clone 後は、

    % git submodule init
    % git submodule update

を必ず行なってください。
