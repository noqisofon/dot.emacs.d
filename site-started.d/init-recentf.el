;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-recentf.el -- Emacs init setting elisp file

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

;; 最近使ったファイルの一覧を表示します。
(recentf-mode t)
;; メニューに表示するファイル名を 10 までにします。
(setq recentf-max-menu-items 10)
;; 最大 15 ファイルまで記録します。
(setq recentf-max-saved-items 15)

;; 最近使ったファイルを別のバッファ領域に表示します。
(define-key global-map (kbd "C-c r") 'recentf-open-files)

(provide 'init-recentf)
;; init-recentf.el ends here
