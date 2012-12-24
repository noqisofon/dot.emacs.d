;;; init-ibus.el --- 

;; Copyright (C) 2012  ned rihine

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
(require-if-exists ibus)
(add-hook 'after-init-hook 'ibus-mode-on)

;; 総てのバッファで入力状態を共有します。
(setq ibus-mode-local nil)
;;; カーソル位置で予測桜甫ウィンドウを表示します。
;(setq ibus-prediction-window-position t)
;; iserarch 時はオフにしておきます。
(ibus-disable-isearch)
;; mini buffer でもオフにしておきます。
(add-hook 'minibuffer-setup-hook 'ibus-disable)

;(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)

(provide 'init-ibus)
;;; init-ibus.el ends here
