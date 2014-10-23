;;; init-locale.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2014  ned rihine

;; Author: ned rihine <ned.rihine@gmail.com>
;; Keywords: 

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
;; 日本語環境を指定します。
(if *windows-p*
    (set-language-environment "Japanese")
  ;; else
  (set-language-environment "utf-8"))

;;; Char code:
(if *windows-p*
    (let ((default-coding 'japanese-shift-jis-dos)
          (clipboard-coding 'utf-16le-dos))
      ;; 
      (if (fboundp 'set-w32-system-coding-system)
          (set-w32-system-coding-system default-coding))
      ;; デフォルトの文字コードです。
      (if (fboundp 'set-default-coding-system)
          (set-default-coding-system default-coding))
      ;; 端末の文字コードです。
      (set-terminal-coding-system default-coding)
      ;; Windows NT の内部文字コードは UTF-16LE なので、クリップボードのエンコードを utf-16le-dos にしておきます。
      (set-clipboard-coding-system clipboard-coding)
      ;; 通常キーボードを使用して打つ文字です。
      (set-keyboard-coding-system default-coding)
      ;; 新規作成するバッファのエンコードです。
      (prefer-coding-system default-coding))
  ;; else
  (let ((default-coding 'utf-8-unix))
    (if (fboundp 'set-default-coding-system)
        (set-default-coding-system default-coding))
    (set-terminal-coding-system default-coding)
    (if (fboundp 'set-clipboard-codng-system)
        (set-clipboard-codng-system default-coding))
    (if (fboundp 'prefer-coding-system-coding)
        (prefer-coding-system-coding default-coding))))

;; (cond
;;  (*windows-nt-p*
;;   (setq file-name-coding-system 'sjis)
;;   (setq locale-coding-system 'utf-8))
;;  (t
;;   (setq file-name-coding-system 'utf-8)
;;   (setq locale-coding-system 'utf-8)))

(provide 'init-locale)
;;; init-locale.el ends here
