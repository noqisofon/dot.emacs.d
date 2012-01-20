;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-shell.el -- Emacs init setting elisp file

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

(cond
 (*windows-p*
  ;; MSYS の bash を使用します。
  (setq explicit-shell-file-name "bash.exe")
  (setq shell-file-name "sh.exe")

  ;; SHELL で ^M が付く場合は ^M を削除します。
  (add-hook 'shell-mode-hook
            (lambda ()
              (set-buffer-process-coding-system 'undecided-dos 'sjis-unix)))
  ;; shell-mode での保管(for drive letter)
  (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.,:()-")

  ;; shell-mode で上下で補完します。
  (setq shell-mode-hook
        (function (lambda ()
                    (define-key shell-mode-map [up] 'comint-previous-input)
                    (define-key shell-mode-map [down]
                                'comint-next-input))))))

(provide 'init-shell)
;; init-shell.el ends here
