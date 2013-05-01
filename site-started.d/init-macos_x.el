;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-macosx_x.el -- Emacs init setting elisp file

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


;; ディスプレイ。
(require 'init-display)

;; recentf。
(require 'init-recentf)

;; menu-tree。
;;(require 'init-menu-tree)

;; カラーテーマ。
(require 'init-color-theme)

;; 行数。
(require 'init-line-number)

;; Elscreen。
(require 'init-elscreen)

;; キーバインド。
(require 'init-keybind)

;; タイムスタンプ。
(require 'time-stamp)

;; スクロール。
(require 'init-scrolling)

;; セッション。
(require 'init-session)

;; highlight line。
(require 'init-hl-line)

;; Yasnippet。
(require 'init-yasnippet)

;; markdown 用。
(require 'init-markdown)

;; Ruby 用。
(require 'init-ruby)

;; htmlize 用。
(require 'init-htmlize)

;; C 言語ファミリー用。
(require 'init-c-common)

;; anything 用。
(require 'init-anything)

;; org-mode 用。
(require 'init-org-mode)

;; SGML 用。
(require 'init-sgml)

;; zencoding 用。
(require 'init-zencoding)

(provide 'init-macos_x)
;; init-macosx_x.el ends here
