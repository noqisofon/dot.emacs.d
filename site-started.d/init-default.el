;;; init-default.el --- 

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

;; ディスプレイ。
(require 'init-display)

;; emacsclient 用。
(require 'init-emacsclient)

;; auto-insert 用。
(require 'init-auto-insert)

;; モードライン。
(require 'init-modeline)

;; recentf。
(require 'init-recentf)

;; menu-tree。
(require 'init-menu-tree)

;; カラーテーマ。
(require 'init-color-theme)

;; 行数。
(require 'init-line-number)

;; Elscreen。
(require 'init-elscreen)

;; キーバインド。
(require 'init-keybind)

;; タイムスタンプ。
(require 'init-time-stamp)

;; タイムスタンプ。
(require 'time-stamp)

;; スクロール。
(require 'init-scrolling)

;; セッション。
(require 'init-session)

;; highlight line。
(require 'init-hl-line)

;; Yasnippet。
(require 'init-yasnippet)

;; anything 用。
(require 'init-anything)

;; htmlize 用。
(require 'init-htmlize)


(provide 'init-default)
;;; init-default.el ends here