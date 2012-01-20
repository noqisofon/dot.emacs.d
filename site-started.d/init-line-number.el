;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-line-number.el -- Emacs init setting elisp file

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

;;; 行番号・桁番号をモードラインに表示する・しない設定
(line-number-mode t)   ;; 行番号。t なら表示、nil なら非表示
(column-number-mode t) ;; 桁番号。t なら表示、nil なら非表示

;; ** 行番号をデフォルトで表示します。
(if *emacs22-p*
    ;; 23 以上から linum.el が入っているので要りませんが、Meadow3 は 22 なので
    ;; require-if-exists が必要です。
    (require-if-exists linum))
(require-if-exists linum+)

;; デフォルトで linum-mode を有効にします。
(add-hook-lambda 'find-file-hook nil
                 (linum-mode 1))
(global-linum-mode 1)
;; 7 桁分の領域を確保して行番号を入れます。
(setq linum-format "%7d")

(provide 'init-line-number)
;; init-line-number.el ends here
