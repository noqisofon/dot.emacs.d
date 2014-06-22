;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-anything.el -- Emacs init setting elisp file

;; Copyright (c) 2009-2014 ned rihine

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

(defvar org-directory "")

;; (require-if-exists anything-config
;;                    (setq anything-sources (list anything-c-source-buffers
;;                                                 anything-c-source-bookmarks
;;                                                 anything-c-source-recentf
;;                                                 anything-c-source-file-name-history
;;                                                 anything-c-source-locate))

;;                    (define-key anything-map (kbd "C-p") 'anything-previous-line)
;;                    (define-key anything-map (kbd "C-n") 'anything-next-line)
;;                    (define-key anything-map (kbd "C-v") 'anything-next-source)
;;                    (define-key anything-map (kbd "M-v") 'anything-previous-source)

;;                    (global-set-key (kbd "C-;") 'anything))
(require-if-exists helm-config
                   (helm-mode 1)

                   (define-key global-map (kbd "M-x")     'helm-M-x)
                   (define-key global-map (kbd "C-x C-f") 'helm-find-files)
                   (define-key global-map (kbd "C-x C-r") 'helm-recentf)
                   (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
                   (define-key global-map (kbd "C-c i")   'helm-imenu)
                   (define-key global-map (kbd "C-x b")   'helm-buffers-list)

                   (define-key helm-map (kbd "C-h") 'delete-backward-char)
                   (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
                   (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
                   (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action))

(provide 'init-anything)
;; init-anything.el ends here
