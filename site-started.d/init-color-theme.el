;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-color-theme.el -- Emacs init setting elisp file

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

;; 対応する括弧を色表示します。
(show-paren-mode t)
;; 括弧の背景を灰色にします。
(set-face-background 'show-paren-match-face "gray85")

(setq color-theme-load-all-themes nil)
(setq color-theme-libraries nil)

(lazyload (color-theme-initialize) "color-theme"
          (require 'color-theme-ntemacs-like)
          (color-theme-ntemacs-like))
(color-theme-initialize)

(provide 'init-color-theme)
;; init-color-theme.el ends here
