;;; -*- mode: emacs-lisp; coding: utf-8-unix; indent-tabs-mode: nil; -*-

;; init-org-mode.el -- Emacs init setting elisp file

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

(setq org-directory "~/var/memo")

(require-if-exists org-mode
                   (setq org-startup-truncated nil)
                   (setq org-return-follows-link t)
                   (push 'auto-mode-alist '("\\.org$" . org-mode))
                   ;;(org-remember-insinuate)
                   (setq org-export-default-language "ja")
                   (setq org-default-notes-file (concat org-directory "/agenda.org"))
                   (setq org-remember-templates
                         '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
                           ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
                           ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")))

                   (set-face-foreground 'org-level-1 "#7fb000")
                   (set-face-foreground 'org-level-2 "#7f9142")
                   (set-face-foreground 'org-level-3 "#00379c")
                   (set-face-foreground 'org-level-4 "#212ca4")
                   (set-face-foreground 'org-level-5 "#6a40ad")
                   (set-face-foreground 'org-level-6 "#8c3e13")

                   (set-face-attribute 'org-document-title nil  :height 1.0))

(provide 'init-org-mode)
;; init-org-mode.el ends here
