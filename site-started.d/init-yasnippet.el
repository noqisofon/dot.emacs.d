;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-yasnippet.el -- Emacs init setting elisp file

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

;; スニペットの位置を設定します。
(setq yas/root-directory (concat user-emacs-directory "share/snippets"))
;;(setq yas/root-directory '("~/.emacs.d/site-lisp/yasnippet/snippets"))

(require-if-exists yasnippet ;; not yasnippet-bundle
                   (yas/initialize)
                   ;;(mapc 'yas/load-directory yas/root-directory)
                   (yas/load-directory yas/root-directory))

(provide 'init-yasnippet)
;; init-yasnippet.el ends here
