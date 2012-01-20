;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-session.el -- Emacs init setting elisp file

;; Copyright (c) 2009-2012 ned rihine

;; Author: ned rihine <ned.rihine@gmail.com>
;; Keyword: tools

;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
 
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <http:;;www.gnu.org/licenses/>.

(require-if-exists session
                   ;; (via: http://d.hatena.ne.jp/gan2/20070624/1182686652)
                   (setq session-initialize '(de-sageplace session keys menus places)
                         session-globals-include '((kill-ring 50)
                                                   (session-file-alist 500 t)
                                                   (file-name-history 10000)))
                   ;; これがないと file-name-history に 500 個保存するまえに max-string に達します。
                   (setq session-globals-max-string 1000000)
                   ;; デフォルトでは 30 です。
                   (setq history-length t)
                   ;; セッションファイルは ~/ に作成します。
                   (setq session-save-file "~/.session")
                   ;; 初期化後に呼び出されるフックにセッションの初期化用関数を引っ掛けます。
                   (add-hook 'after-init-hook 'session-initialize)
                   ;; 前回閉じたときの位置にカーソルを復帰するようにします。
                   (setq session-undo-check -1))

(provide 'init-session)
;; init-session.el ends here
