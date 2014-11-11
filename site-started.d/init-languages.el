;;; init-languages.el --- 

;; Copyright (C) 2013  ned rihine

;; Author: ned rihine <ned.rihine@gmail.com>
;; Keywords: tools

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
;; shell script 用。
(require-if-exists init-shell-script)

;; C 言語ファミリー用。
(require-if-exists init-c-common)

;; Lisp ファミリー用。
(require-if-exists init-lisp-common)

;; Objective-C 用。
(require-if-exists init-objc)

;; Smalltalk 用。
(require-if-exists init-smalltalk)

;; ecmascript 用。
(require-if-exists init-ecmascript)

;; javacript 用。
(require-if-exists init-javascript)

;; vala 用。
(require-if-exists init-vala)

;; C# 用。
(require-if-exists init-csharp)

;; Nemerle 用。
(require-if-exists init-nemerle)

;; D 用。
(require-if-exists init-d)

;; Ruby 用。
(require-if-exists init-ruby)

;; Scala 用。
(require-if-exists init-scala)

;; clojure 用。
(require-if-exists init-clojure)

;; scheme 用。
(require-if-exists init-scheme)

;; org-mode 用。
(require-if-exists init-org-mode)

;; SGML 用。
(require-if-exists init-sgml)

;; CMake 用。
(require-if-exists init-cmake)

;; markdown 用。
(require-if-exists init-markdown)

;; yaml 用。
(require-if-exists init-yaml)

;; haml 用。
(require-if-exists init-haml)

;; sass 用。
(require-if-exists init-sass)

;; less 用。
(require-if-exists init-less)

;; coffeescript 用。
(require-if-exists init-coffee)

;; PHP 用
(require-if-exists init-php)

;; zencoding 用。
(require-if-exists init-zencoding)

;; eldoc。
(require-if-exists init-eldoc)

;; C 用の eldoc。
(require-if-exists init-c-eldoc)

;; Git 用。
(require-if-exists init-magit)

;; Haskell 用。
(require-if-exists init-haskell)

;; AsciiDoc 用。
(require-if-exists init-asciidoc)

;; BASIC 用。
(require-if-exists init-basic)

;; Rust 用
(require-if-exists init-rust)

;; Dart 用
(require-if-exists init-dart)

(provide 'init-languages)
;;; init-languages.el ends here
