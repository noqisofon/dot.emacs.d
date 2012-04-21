;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init.el -- Emacs init setting elisp file

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
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Profiles:

(setq user-full-name "ned rihine")
(setq user-mail-address "ned.rihine@gmail.com")

;;; Debug modes:
;; TODO: デバッグモード時のみ t にする。
;(setq debug-on-error t)

;; Emacs 設定ディレクトリを指定します。
;; Emacs 23.1 以上では user-emacs-directory が用意されているのでそれを利用します。
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;; 引数を load-path へ追加します。
(defun add-to-load-path (&rest paths)
  (let (path)
    ;; dolist は Emacs 21 からの標準関数です。
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        ;; normal-top-level-add-subdirs-to-load-path はディレクトリ内で ^[A-Za-z] なものだけ追加します。
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "site-lisp" "site-started.d")


;;;
;; 
(defvar *emacs20-p*
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar *emacs21-p*
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar *emacs22-p*
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar *emacs23-p*
  (and (equal emacs-major-version 23)
       (null (featurep 'xemacs))))

(defvar *linux-p* (equal system-type 'gnu/linux))

(defvar *darwin-p* (equal system-type 'darwin))

(defvar *usg-unix-v-p* (equal system-type 'usg-unix-v))

(defvar *windows-nt-p* (equal system-type 'windows-nt))

(defvar *ms-dos-p* (equal system-type 'ms-dos))

(defvar *nextstep-p* (equal window-system 'ns))

(defvar *unix-like-p*
  (or *linux-p*
      *darwin-p*
      *usg-unix-v-p*))

(defvar *windows-p*
  (and (null *unix-like-p*)
       (or *windows-nt-p*
           *ms-dos-p*)))

(defvar *macosx-p*
  (and *unix-like-p*
       (null *windows-p*)
       (and *nextstep-p*
            *darwin-p*)))

(defvar *x-window-system-p*
  (and *unix-like-p*
       (equal window-system 'x)))

(defvar *meadow-p* (featurep 'meadow))
(defvar *meadow1-p* (and *meadow-p* *emacs20-p*))
(defvar *meadow2-p* (and *meadow-p* *emacs21-p*))
(defvar *meadow3-p* (and *meadow-p* *emacs22-p*))

(defvar *ntemacs-p* (and (not *meadow-p*) *windows-p*))

(defvar *xemacs-p* (featurep 'xemacs))
(defvar *xemacs-no-mule-p*
  (and *xemacs-p* (not (featurep 'mule))))

;; 日本語環境を指定します。
;;(set-language-environment "Japanese")
(set-language-environment "utf-8")

;;; Char code:
;; (if *windows-p*
;;     (let ((default-coding 'japanese-shift-jis-dos)
;;           (clipboard-coding 'utf-16le-dos))
;;       ;; 
;;       (if (foundp 'set-w32-system-coding-system)
;;           (set-w32-system-coding-system default-coding))
;;       ;; デフォルトの文字コードです。
;;       (if (fboundp 'set-default-coding-system)
;;           (set-default-coding-system default-coding))
;;       ;; 端末の文字コードです。
;;       (set-terminal-coding-system default-coding)
;;       ;; Windows NT の内部文字コードは UTF-16LE なので、クリップボードのエンコードを utf-16le-dos にしておきます。
;;       (set-clipboard-coding-system clipboard-coding)
;;       ;; 通常キーボードを使用して打つ文字です。
;;       (set-keyboard-coding-system default-coding)
;;       ;; 新規作成するバッファのエンコードです。
;;       (prefer-coding-system 'default-coding))
;;   ;; else
;;     (let ((default-coding 'utf-8-unix))
;;       (if (fboundp 'set-default-coding-system)
;;           (set-default-coding-system default-coding))
;;       (set-terminal-coding-system default-coding)
;;       (set-clipboard-codng-system default-coding)
;;       (prefer-coding-system-coding default-coding)))
(cond
 (*windows-nt-p*
  (setq file-name-coding-system 'sjis)
  (setq locale-coding-system 'utf-8))
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)))

;; 全環境共通設定を読み込みます。
(require 'init-global)

;; 環境依存設定を読み込みます。
(cond
 (*macosx-p* (require 'init-macos_x))
 (*windows-p* (require 'init-windows-nt))
 (*unix-like-p* (require 'init-unix-like)))

;; カスタムファイルの場所を指定します。
(setq *custom-filepath* (expand-file-name "private/customize.el" user-emacs-directory))

;; 終了時にバイトコンパイルを行います。
(add-hook-lambda 'kill-emacs-query-functions
                 (if (file-newer-than-file-p (concat user-emacs-directory "init.el") (concat user-emacs-directory "init.elc"))
                     (byte-compile-file (concat user-emacs-directory "init.el"))
                   (byte-recompile-directory (concat user-emacs-directory "site-lisp") 0)
                   (byte-recompile-directory (concat user-emacs-directory "private") 0)
                   (byte-recompile-directory (concat user-emacs-directory "site-started.d") 0)))

(if (not (fboundp 'second))
    (defun second (li)
         (nth 1 li)))

(if (not (fboundp 'third))
    (defun third (li)
         (nth 2 li)))

;; 起動時間を計測します。
(when *emacs23-p*
  (defun present-startup-time ()
    (message "Emacs loaded in %d ms."
             (/ (- (+ (third after-init-time) (* 1000000 (second after-init-time)))
                   (+ (third before-init-time) (* 1000000 (second before-init-time))))
                1000)))
  (add-hook 'after-init-hook 'present-startup-time))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-document-title ((((class color) (background light)) (:foreground "midnight blue" :weight bold :height 1.0)))))
