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

;; 初期化した後のフックに ibus-mode-on を追加しておきます。
(add-hook 'after-init-hook 'ibus-mode-on)

;; ibus-el-agent を実行する python のコマンドを設定します。
(setq ibus-python-shell-command-name "python2")

;; ibus の Emacs 用のエージェントプログラムのパスを設定します。
(setq ibus-agent-file-name "/usr/share/emacs/site-lisp/ibus/ibus-el-agent")

;; 総てのバッファで入力状態を共有します。
(setq ibus-mode-local nil)

;; カーソル位置で予測候補ウィンドウを表示します。
(setq ibus-prediction-window-position t)

;; iserarch 時はオフにしておきます。
(ibus-disable-isearch)

;; mini buffer でもオフにしておきます。
(add-hook 'minibuffer-setup-hook 'ibus-disable)

;; カーソル位置で予測候補窓を表示するようにします。
(setq ibus-prediction-window-position t)

;; 半角／全角キーでインプットメソッドを切り替えるようにします。
(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)

(provide 'init-ibus)
;;; init-ibus.el ends here
