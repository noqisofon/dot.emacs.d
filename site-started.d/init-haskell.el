;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-
;;; init-haskell.el --- 

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
(require-if-exists haskell-mode)


(push '("\\.hs$" . haskell-mode) auto-mode-alist)

;; `haskell-indentation', Kristof Bastiaensen
;;   Intelligent semi-automatic indentation, mark two. How to enable:
;; (custom-set-variables
;;  '(haskell-mode-hook '(turn-on-haskell-indentation)))

;; `haskell-indent', Guy Lapalme
;;   Intelligent semi-automatic indentation. How to enable:
(custom-set-variables
 '(haskell-mode-hook '(turn-on-haskell-indentation)))

;; `haskell-simple-indent', Graeme E Moss and Heribert Schuetz
;;   Simple indentation. How to enable:
;; (custom-set-variables
;;  '(haskell-mode-hook '(turn-on-haskell-simple-indent)))

(push '("runghc" . haskell-mode) interpreter-mode-alist)
(push '("runhaskell" . haskell-mode) interpreter-mode-alist)


(provide 'init-haskell)
;;; init-haskell.el ends here
