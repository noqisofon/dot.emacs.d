;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-auto-insert.el -- Emacs init setting elisp file

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

(require-if-exist autoinsert)

;; テンプレートが入っているディレクトリを指定します。
(setq auto-insert-directory "~/Templates/auto-insert/")

;; 書くファイルによってテンプレートを切り替えるようにします。
(setq auto-insert-alist
      (nconc '(
               ("\\.c$"     . ["template.c" my-template])
               ("\\.h$"     . ["template.h" my-template])
               ("\\.cpp$"   . ["template.cpp" my-template])
               ("\\.hxx$"   . ["template.hxx" my-template])
               ) auto-insert-alist))

(require-if-exist cl)

(defvar template-replacements-alists
  '(
    ("%file%"                 . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-with-out-ext%"    . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"        . (lambda () (format "__%s_%s__" (upcase (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))) (upcase "h"))))
    ))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda (c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        template-replacement-alists)
  (goto-char (point-max))
  (message "done."))

(add-hook 'find-file-not-found-hooks 'auto-insert)

(provide 'init-auto-insert)
;; init-auto-insert.el ends here
