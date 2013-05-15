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

(let (
      ;; フレーム(窓)の幅です。
      (frame-width 170)
      ;; フレーム(窓)の高さです。
      (frame-height 20)
      ;; フレーム(窓)の左上の位置(X 軸的な意味で)です。
      (frame-top 5)
      ;; フレーム(窓)の左上の位置(Y 軸的な意味で)です。
      (frame-left 5)
      ;; フレーム(窓)の透明度をです。
      (frame-alpha 95)
      ;; フレーム(窓)のカーソルです。
      ;; 基本的に縦棒(bar)を設定します。
      ;; Meadow3 では hairline-caret という Windows のメモ帳とかでの縦棒？に似たシンボルがあるので、それを設定します。
      ;; それ以外では普通に bar を設定します。
      (frame-cursor-type (if *meadow3-p*
                             'hairline-caret
                           ;; else
                           'bar)))
  ;; フレームのパラメータを設定します。
  (setq default-frame-alist
        (append (list (cons 'width frame-width)
                      (cons 'height frame-height)
                      (cons 'top frame-top)
                      (cons 'left frame-left)
                      (cons 'alpha frame-alpha))
                default-frame-alist))
  ;; カーソルを設定します。
  (if (fboundp 'set-cursor-type)
      ;; Meadow では、set-cursor-type っていう関数があって、それを使ってもよいのですが、
      ;; 他の Emacsen では無いので、default-frame-alist に設定します。
      (set-cursor-type frame-cursor-type)
    ;; else
    (add-to-list 'default-frame-alist (cons 'cursor-type frame-cursor-type))))

;; フォント名を指定して使用するフォントを設定します。
(defun setting-font (font-name)
  (let* ((fontset-name font-name)
         (size 13)
         (ascii-font font-name)
         (multibyte-font font-name)
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

(let ((font-name)
      (after-font-name-list '("Ricty" "TakaoGothic" "IPAGothic" "MS Gothic")))
  (while (not (null after-font-name-list))
    ;; x:xs を設定します。
    (setq font-name (car after-font-name-list)
          after-font-name-list (cdr after-font-name-list))
    ;; font-name が存在するかどうか調べます。
    (if (find-font (font-spec :family font-name))
      (progn
        (setting-font font-name)
        ;; 存在したら、after-font-name-list に nil を設定して終了するようにします。
        (setq after-font-name-list nil)))))

;; (cond
;;  ((find-font (font-spec :family ))
;;   (setting-font "Ricty"))

;;  ((find-font (font-spec :family ))
;;   (setting-font "TakaoGothic"))

;;  ((find-font (font-spec :family ))
;;   (setting-font "IPAGothic")))

;; デフォルトのフレームパラメータでフォンとセットを指定します。
;;(add-to-list 'default-frame-alist '(font . "fontset-takao-gothic"))

;; (if *macosx-p*
;;     ;; フォントサイズの比を指定します。
;;     (dolist (elt '(("^-apple-hiragino.*" . 1.2)
;;                    (".*osaka-bold.*" 1.2)
;;                    (".*osaka-medium.*" 1.2)
;;                    (".*courier-bold.*" 1.0)
;;                    (".*monaco cy-bold-.*-mac-cyrillic" 0.9)
;;                    (".*monaco-bold-.*-mac-roman" 0.9)))
;;       (add-to-list 'face-font-rescale-alist elt)))

;;(set-face-font 'default "fontset-takao-gothic")

;; 行末の空白を表示しません(ウザいので)。
;(setq-default show-trailing-whitespace nil)

;; EOB を表示します。
(setq-default indicate-empty-lines t)

;; マーク領域を色付けします。
(setq transient-mark-mode t)

;; 変更点に色付けしません(ウザいので)。
;(global-highlight-changes-mode nil)
;(setq highlight-changes-visibility-initial-state nil)

;;; Fringe
(setq-default indicate-buffer-boundaries 'left)
;; 右フリンジの上下にマークをつける
(setq-default indicate-buffer-boundaries 'right)

;; 左フリンジの上と右フリンジの下にマークをつける
(setq-default indicate-buffer-boundaries '((top . left) (t . right)))
;; 右フリンジの上と左フリンジの下にマークをつける
(setq-default indicate-buffer-boundaries '((top . right) (t . left)))
;; 右フリンジの上にのみマークをつける
(setq-default indicate-buffer-boundaries '((top . right) (t . nil)))

(provide 'init-display)
;; init-display.el ends here
