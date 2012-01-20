;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-keybind.el -- Emacs init setting elisp file

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


;; i-search for japanese
(define-key isearch-mode-map (kbd "C-k") 'isearch-edit-string)

;; M-g で指定行にカーソルを飛ばします。
(global-set-key (kbd "M-g")
                '(lambda (x)
                  (interactive "Line to goto: ")
                  (goto-line x)))

;; C-\ でアンドゥできるようにします。
(global-set-key (kbd "C-\\") 'undo)

;; *** comment/uncomment-regeon
;; C-x ; でコメントアウト
;; C-x : でコメントをはずす
(global-set-key (kbd "C-x ;") 'comment-region)
(fset 'uncomment-region "\C-u\C-[xcomment-region\C-m")
(global-set-key (kbd "C-x :") 'uncomment-region)

;; 自動インデントを行ないます。
(global-set-key (kbd "C-m") 'newline-and-indent)

(global-set-key (kbd "C-j") 'newline)

;; 最近使ったファイルを別のバッファ領域に表示します。
(define-key global-map (kbd "C-c r") 'recentf-open-files)

(provide 'init-keybind)
;; init-keybind.el ends here
