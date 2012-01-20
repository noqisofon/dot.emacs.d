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

(cond
 ((find-font (font-spec :family "Ricty"))
  (let* ((fontset-name "ricty")
         (size 10)
         (ascii-font "Ricty")
         (multibyte-font "Ricty")
         (h (* size 10))
         (font (format "%s-%d:weight=normal:slant=normal" ascii-font size))
         (ascii-fontspec (font-spec :family ascii-font))
         (multibyte-fontspec (font-spec :family multibyte-font))
         (fontset (create-fontset-from-ascii-font font nil fontset-name)))
    (set-face-attribute 'default nil :family ascii-font)
    (set-fontset-font fontset 'japanese-jisx0213.2004-1 multibyte-fontspec)
    (set-fontset-font fontset 'japanese-jisx0213-2 multibyte-fontspec)
    (set-fontset-font fontset 'katakana-jisx0201 multibyte-fontspec) ; 半角カナ
    (set-fontset-font fontset '(#x0080 . #x024F) ascii-fontspec)     ; 分音符付きラテン
    (set-fontset-font fontset '(#x0370 . #x03FF) ascii-fontspec)     ; ギリシャ文字
    ))

 ((find-font (font-spec :family "TakaoGothic"))
  (let* ((fontset-name "takao-gothic")
         (size 10)
         (ascii-font "TakaoGothic")
         (multibyte-font "TakaoGothic")
         (h (* size 10))
         (font (format "%s-%d:weight=normal:slant=normal" ascii-font size))
         (ascii-fontspec (font-spec :family ascii-font))
         (multibyte-fontspec (font-spec :family multibyte-font))
         (fontset (create-fontset-from-ascii-font font nil fontset-name)))
    (set-face-attribute 'default nil :family ascii-font)
    (set-fontset-font fontset 'japanese-jisx0213.2004-1 multibyte-fontspec)
    (set-fontset-font fontset 'japanese-jisx0213-2 multibyte-fontspec)
    (set-fontset-font fontset 'katakana-jisx0201 multibyte-fontspec) ; 半角カナ
    (set-fontset-font fontset '(#x0080 . #x024F) ascii-fontspec)     ; 分音符付きラテン
    (set-fontset-font fontset '(#x0370 . #x03FF) ascii-fontspec)     ; ギリシャ文字
    ))

 ((find-font (font-spec :family "IPAGothic"))
  (let* ((fontset-name "ipa-gothic")
         (size 10)
         (ascii-font "IPAGothic")
         (multibyte-font "IPAGothic")
         (h (* size 10))
         (font (format "%s-%d:weight=normal:slant=normal" ascii-font size))
         (ascii-fontspec (font-spec :family ascii-font))
         (multibyte-fontspec (font-spec :family multibyte-font))
         (fontset (create-fontset-from-ascii-font font nil fontset-name)))
    (set-face-attribute 'default nil :family ascii-font)
    (set-fontset-font fontset 'japanese-jisx0213.2004-1 multibyte-fontspec)
    (set-fontset-font fontset 'japanese-jisx0213-2 multibyte-fontspec)
    (set-fontset-font fontset 'katakana-jisx0201 multibyte-fontspec) ; 半角カナ
    (set-fontset-font fontset '(#x0080 . #x024F) ascii-fontspec)     ; 分音符付きラテン
    (set-fontset-font fontset '(#x0370 . #x03FF) ascii-fontspec)     ; ギリシャ文字
    )))

;; デフォルトのフレームパラメータでフォンとセットを指定します。
;;(add-to-list 'default-frame-alist '(font . "fontset-takao-gothic"))

(if *macosx-p*
    ;; フォントサイズの比を指定します。
    (dolist (elt '(("^-apple-hiragino.*" . 1.2)
                   (".*osaka-bold.*" 1.2)
                   (".*osaka-medium.*" 1.2)
                   (".*courier-bold.*" 1.0)
                   (".*monaco cy-bold-.*-mac-cyrillic" 0.9)
                   (".*monaco-bold-.*-mac-roman" 0.9)))
      (add-to-list 'face-font-rescale-alist elt)))

;;(set-face-font 'default "fontset-takao-gothic")

;; 行末の空白を表示しません(ウザいので)。
(setq-default show-trailing-whitespace nil)

;; EOB を表示します。
(setq-default indicate-empty-lines t)

;; マーク領域を色付けします。
(setq transient-mark-mode t)

;; 変更点に色付けしません(ウザいので)。
(global-highlight-changes-mode nil)
(setq highlight-changes-visibility-initial-state nil)

;; 標準の hl-line だと結構邪魔なので拡張機能に変更。
(require-if-exists hl-line+)

(provide 'init-display)
;; init-display.el ends here
