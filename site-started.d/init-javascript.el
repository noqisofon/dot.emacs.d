;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-javascript.el -- Emacs init setting elisp file

;; Copyright (c) 2009-2014 ned rihine

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

(require-if-exists js)
(lazyload (js2-mode) "js2-mode")

;;(delete (cons "\\.js$" 'js-mode) auto-mode-alist)
(push '("\\.js$" . js2-mode) auto-mode-alist)

(add-hook-lambda 'js2-mode-hook
                 (setq js-indent-level 4
                       ;; 保存時に行末の空白を削除しません。
                       js2-cleanup-white-space nil
                       ;; 開き括弧の入力の際に、閉じ括弧を自動で入力しません。
                       js2-mirror-mode nil
                       js2-bounce-indent-flag nil
                       indent-tabs-mode nil
                       c-basic-offset 4))

(provide 'init-javascript)
;; init-javascript.el ends here
