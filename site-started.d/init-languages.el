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
(require 'init-shell-script)

;; C 言語ファミリー用。
(require 'init-c-common)

;; Objective-C 用。
(require 'init-objc)

;; Smalltalk 用。
(require 'init-smalltalk)

;; ecmascript 用。
(require 'init-ecmascript)

;; javacript 用。
(require 'init-javascript)

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

;; less 用。
(require 'init-less)

;; coffeescript 用。
(require 'init-coffee)

;; zencoding 用。
(require 'init-zencoding)

;; eldoc。
(require 'init-eldoc)

;; C 用の eldoc。
(require 'init-c-eldoc)

;; Git 用。
(require 'init-magit)

;; Haskell 用。
(require 'init-haskell)

;; AsciiDoc 用。
(require 'init-asciidoc)


(provide 'init-languages)
;;; init-languages.el ends here
