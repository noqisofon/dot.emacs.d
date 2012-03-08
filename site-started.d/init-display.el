;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-display.el -- Emacs init setting elisp file

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

(setq default-frame-alist
      (append (list
               '(width . 170)
               '(height . 20)
               '(top . 5)
               '(left . 5))
              default-frame-alist))

(setq *frame-alpha* 85)

(if *meadow3-p*
    (set-frame-parameter nil 'alpha *frame-alpha*)
  ;; else
  (add-to-list 'default-frame-alist (cons 'alpha *frame-alpha*)))

;; カーソルを縦棒にします。
(if (fboundp 'set-cursor-type)
    (set-cursor-type 'hairline-caret)
  ;; else
  (if *meadow3-p*
      (add-to-list 'default-frame-alist '(cursor-type . hairline-caret))
    ;; else
    (add-to-list 'default-frame-alist '(cursor-type . bar))))

(when (>= emacs-major-version 23)
  (set-face-attribute 'default nil
                      :family "ricty"
                      :height 140)
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0212
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'mule-unicode-0100-24ff
   '("monaco" . "iso10646-1"))
  (setq face-font-rescale-alist
        '(("^-apple-hiragino.*" . 1.2)
          (".*osaka-bold.*" . 1.2)
          (".*osaka-medium.*" . 1.2)
          (".*courier-bold-.*-mac-roman" . 1.0)
          (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
          (".*monaco-bold-.*-mac-roman" . 0.9)
          ("-cdac$" . 1.3))))

;; 行末の空白を表示しません(ウザいので)。
;(setq-default show-trailing-whitespace nil)

;; EOB を表示します。
(setq-default indicate-empty-lines t)

;; マーク領域を色付けします。
(setq transient-mark-mode t)

;; 変更点に色付けしません(ウザいので)。
;(global-highlight-changes-mode nil)
;(setq highlight-changes-visibility-initial-state nil)

(provide 'init-display)
;; init-display.el ends here
