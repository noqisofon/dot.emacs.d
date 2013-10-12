;;; init-version-control.el --- 

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

;;; Backup file:
;; バックアップファイルを作成します。
(setq backup-inhibited nil)
;; 簡易バージョンコントロール機能を有効にします。
(setq version-control t)

(when version-control
  ;; 新しいものを 12 つまで残すようにします。
  (setq kept-new-version 12)
  ;; 古いものを 12 つまで残すようにします。
  (setq kept-old-version 12)
  ;; 古いバージョンを消す際、Emacs から尋ねないようにします。
  (setq delete-old-versions t)

  ;; TODO: magit とかも require する。
  (require 'init-magit))

;; 終了時にオートセーブファイルを削除しないようにします。
(setq delete-auto-save-files nil)

(provide 'init-version-control)
;;; init-version-control.el ends here
