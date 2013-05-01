;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-
;;; init-uim.el --- 

;; Copyright (C) 2013  ned rihine

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
(require-if-exists uim)

;; ;; デフォルトの IM を uim 提供のものに設定 (以下は Anthy の例)
;; (setq default-input-method "japanese-anthy-uim")
(setq default-input-method "japanese-mozc-uim")

(global-set-key (kbd "<zenkaku-hankaku>") 'uim-mode)


;; 普通のカスタマイズ
;; ==================

;; * uim-mode のデフォルトの IM を uim 全体と独立に設定する

;;   デフォルトでは、uim-mode が有効になると、uim-pref-gtk などの
;;   ツールで設定された IM が有効になります。

;;   もし、uim 全体の設定とは異なるIMをデフォルトで利用したければ、
;;   uim-default-im-engine 変数にそのIM名を設定して下さい。例えば
;;   uim-anthy をデフォルトで利用したければ、以下を記述します。
(setq uim-default-im-engine "anthy")


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
(setq uim-candidate-display-inline t)


(set-face-foreground 'uim-preedit-highlight-face "white")
(set-face-background 'uim-preedit-highlight-face "blue")

(provide 'init-uim)
;;; init-uim.el ends here
