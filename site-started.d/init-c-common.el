;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-c-common.el -- Emacs init setting elisp file

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

(add-hook-lambda 'c-mode-common-hook
 ;; cc-mode スタイルにします。
 (c-set-style "cc-mode")
 ;; インデントは空白文字で行ないます。
 (setq indent-tabs-mode nil)
 ;; `;' を押すと自動で改行されるようにします。
 (setq c-auto-newline nil)
 ;; タブキーでインデントを行います。
 (setq c-tab-always-indent t)
 ;; タブ幅を 4 にします。
 (setq tab-width 4)
 ;; インデントを tab-width と同じにします。
 (setq c-indent-level tab-width)
 ;; コメントだけの行も 0 にします。
 (setq c-comment-only-line-offset 0)

 ;; 引数リストの閉じ括弧もインデントします。
 (c-set-offset 'arglist-close 0)
 ;; public などのアクセス修飾子は -3 インデントします。
 (c-set-offset 'access-label -3)
 ;; switch 構文のラベルは c-basic-offset だけインデントします。
 (c-set-offset 'case-label '+)
 ;; 継続行は c-basic-offset 分のインデントを行います。
 (c-set-offset 'statement-cont '+)
 ;; クラスのメンバー初期化リストの 1 行目は c-basic-offset 分インデントします。
 (c-set-offset 'member-init-intro '+))

(provide 'init-c-common)
;; init-c-common.el ends here
