;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-
;;; init-uim.el --- 

;; Copyright (C) 2013-2014  ned rihine

;; Author: ned rihine <ned.rihine@gmail.com>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:


;; Emacs 上で C-SPC が IM の入力モードの切り替えに使われてしまうのを抑止する
;; =============================================================================

;; デスクトップ環境上で IM のオン・オフのキー割り当てに C-SPC を設定していると、uim.el がアクティブになっている時 C-SPC は入力モードの切り替えに使用されます。
;; これを抑止し、set-mark-command として使用するには、以下の設定を .emacs.d/init.el あるいはその他の Emacs カスタム設定用ファイルに追加します。
(add-hook 'uim-load-hook
          '(lambda ()
             (define-key uim-mode-map [67108896] nil)
             (define-key uim-mode-map [0] nil)))

;; ;; デフォルトの IM を uim 提供のものに設定 (以下は Anthy の例)
;; (setq default-input-method "japanese-anthy-uim")
(setq default-input-method "japanese-mozc-uim")

;; init-keybind.el に移動しました。
;;(global-set-key (kbd "<zenkaku-hankaku>") 'uim-mode)


;; 普通のカスタマイズ
;; ==================

;; * uim-mode のデフォルトの IM を uim 全体と独立に設定する

;;   デフォルトでは、uim-mode が有効になると、uim-pref-gtk などの
;;   ツールで設定された IM が有効になります。

;;   もし、uim 全体の設定とは異なるIMをデフォルトで利用したければ、
;;   uim-default-im-engine 変数にそのIM名を設定して下さい。例えば
;;   uim-anthy をデフォルトで利用したければ、以下を記述します。
;; (setq uim-default-im-engine "anthy")
(setq uim-default-im-engine "mozc")


;; * インライン変換候補表示機能をデフォルトで有効にする

;;   uim.el は、変換候補を入力中の文字列のすぐ下 (もしくはすぐ上) に
;;   縦方向に並べて表示する機能を備えています。uim.el ではこれを
;;   「インライン変換候補表示機能」と呼んでいます。

;;   インライン変換候補表示機能は uim.el の最も重要な特徴の一つなのですが、
;;   プロポーショナルフォントを利用している場合、表示が崩れてしまうため、
;;   デフォルトでは無効化されています。

;;   もしあなたが Emacs で等幅フォントを利用しているのであれば、インライン
;;   変換候補表示機能を有効にすることをお勧めします。

;;   インライン変換候補表示機能をデフォルトで有効にしたい場合は、以下の
;;   例のように uim-candidate-display-inline 変数に nil 以外の値を設定します。
(setq uim-candidate-display-inline nil)

;; (set-face-foreground 'uim-preedit-highlight-face "black")
;; (set-face-background 'uim-preedit-highlight-face "blue")

;; (set-face-foreground 'uim-separator-face "blue")

;; (set-face-foreground 'uim-candidate-odd-face "blue")
;; (set-face-background 'uim-candidate-odd-face "white")

;; (set-face-foreground 'uim-candidate-even-face "blue")
;; (set-face-background 'uim-candidate-even-face "yellow")

;; (set-face-foreground 'uim-candidate-selected-face "blue")
;; (set-face-background 'uim-candidate-selected-face "white")

;; (set-face-foreground 'uim-candidate-nth-face "red")
;; (set-face-background 'uim-candidate-nth-face "white")

;; (require-if-exists uim)
(lazyload (uim-mode) "uim")

(provide 'init-uim)
;;; init-uim.el ends here
