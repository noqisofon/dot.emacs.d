;;; init-windows-nt.el --- 

;; Copyright (C) 2012  ned rihine

;; Author: ned rihine <ned.rihine@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:
;; ディスプレイ。
(require 'init-display)

;; emacsclient 用。
(require 'init-emacsclient)

;; auto-insert 用。
(require 'init-auto-insert)

;; モードライン。
(require 'init-modeline)

;; recentf。
(require 'init-recentf)

;; menu-tree。
(require 'init-menu-tree)

;; カラーテーマ。
(require 'init-color-theme)

;; 行数。
(require 'init-line-number)

(if (featurep 'alist)
    ;; Elscreen。
    (require 'init-elscreen))

;; キーバインド。
(require 'init-keybind)

;; タイムスタンプ。
(require 'init-time-stamp)

;; eldoc。
(require 'init-eldoc)

;; C 用の eldoc。
(require 'init-c-eldoc)

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

;; anything 用。
(require 'init-anything)

;; htmlize 用。
(require 'init-htmlize)

;; C 言語ファミリー用。
(require 'init-c-common)

;; Objective-C 用。
(require 'init-objc)

;; Smalltalk 用。
(require 'init-smalltalk)

;; ecmascript 用。
(require 'init-ecmascript)

;; vala 用。
(require 'init-vala)

;; C# 用。
(require 'init-csharp)

;; D 用。
(require 'init-d)

;; Ruby 用。
(require 'init-ruby)

;; Scala 用。
(require 'init-scala)

;; clojure 用。
(require 'init-clojure)

;; Go 用。
(require 'init-go)

;; org-mode 用。
(require 'init-org-mode)

;; SGML 用。
(require 'init-sgml)

;; CMake 用。
(require 'init-cmake)

;; markdown 用。
(require 'init-markdown)

;; yaml 用。
(require 'init-yaml)

;; haml 用。
(require 'init-haml)

;; sass 用。
(require 'init-sass)

;; coffeescript 用。
(require 'init-coffee)

;; zencoding 用。
(require 'init-zencoding)


(provide 'init-windows-nt)
;;; init-windows-nt.el ends here
