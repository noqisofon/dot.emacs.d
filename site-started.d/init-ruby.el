;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-ruby.el -- Emacs init setting elisp file

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
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.

(lazyload (ruby-mode) "ruby-mode")

;; ruby モード。
(push '("\\.rb$" . ruby-mode) auto-mode-alist)
;; インタプリタモードの設定。
(push '("ruby" . ruby-mode) interpreter-mode-alist)

(provide 'init-ruby)
;; init-ruby.el ends here
