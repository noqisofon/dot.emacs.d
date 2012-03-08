;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-hl-line.el -- Emacs init setting elisp file

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

;; カーソルのある行をハイライトします。
(setq hl-line-face 'underline)
(global-hl-line-mode)

;; 標準の hl-line だと結構邪魔なので拡張機能に変更。
(require-if-exists hl-line+)

(defface hlline-face
         '((((class color)
             (background dark))
            (:background "blue" :foreground "white"))
           (((class color)
             (background light))
            (:background "AliceBlue"))
           (t
            ()))
         "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)

(provide 'init-hl-line)
;; init-hl-line.el ends here
