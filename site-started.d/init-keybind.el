;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-keybind.el -- Emacs init setting elisp file

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


;; i-search for japanese
(define-key isearch-mode-map (kbd "C-k") 'isearch-edit-string)

;; M-g で指定行にカーソルを飛ばします。
(global-set-key (kbd "M-g")
                '(lambda (x)
                  (interactive "Line to goto: ")
                  (goto-line x)))

;; C-\ でアンドゥできるようにします。
(global-set-key (kbd "C-\\") 'undo)

;; ;; *** comment/uncomment-regeon
;; ;; C-x ; でコメントアウト
;; ;; C-x : でコメントをはずす
;; (global-set-key (kbd "C-x ;") 'comment-region)
;; (fset 'uncomment-region "\C-u\C-[xcomment-region\C-m")
;; (global-set-key (kbd "C-x :") 'uncomment-region)
(global-set-key (kbd "M-;") 'comment-or-uncomment-region)

;; Enter キーの代わりに C-m を押すことで自動インデントを行ないます。
(global-set-key (kbd "C-m") 'newline-and-indent)

;; Enter キーで改行しない時のために、C-j で開業することができます。
(global-set-key (kbd "C-j") 'newline)

;; C-c t でテンポラリバッファを作成します。
(global-set-key (kbd "C-c t") 'create-temporary-buffer)

;; C-x v f で 現在選択しているバッファの名前を挿入します。
(global-set-key (kbd "C-x v f") 'get-selected-buffer-name)

;; C-x t d でカーソルの後に現在の時刻を ISO 8601 形式で挿入します。
(global-set-key (kbd "C-x t d") 'insert-iso8601format-datetime)

;; 最近使ったファイルを別のバッファ領域に表示します。
(define-key global-map (kbd "C-c r") 'recentf-open-files)

(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)

(provide 'init-keybind)
;; init-keybind.el ends here
