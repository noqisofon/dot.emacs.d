;;; init-infrastructure.el --- 

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

;; recentf。
(require 'init-recentf)

;; デフォルトのバージョンコントロール機能。
(require 'init-version-control)

;; モードライン。
(require 'init-modeline)

;; ツールバー。
(require 'init-toolbar+)

;; 行数。
(require 'init-line-number)

;; タイムスタンプ。
(require 'init-time-stamp)

;; スクロール。
(require 'init-scrolling)

;; emacsclient 用。
(require 'init-emacsclient)

;; auto-insert 用。
(require 'init-auto-insert)

;; magit、または git 用。
(require 'init-magit)

;; ;; menu-tree。
;; (require 'init-menu-tree)

;; カラーテーマ。
(require 'init-color-theme)

;; セッション。
(require 'init-session)

;; highlight line。
(require 'init-hl-line)

;; Elscreen。
(require 'init-elscreen)

;; Yasnippet。
(require 'init-yasnippet)

;; anything 用。
(require 'init-anything)

;; htmlize 用。
(require 'init-htmlize)

;; キーバインド。
(require 'init-keybind)

(provide 'init-infrastructure)
;;; init-infrastructure.el ends here
