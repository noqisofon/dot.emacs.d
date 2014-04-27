;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-scrolling.el -- Emacs init setting elisp file

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

;; ウィンドウの一番下にカーソルがある場合、そこから下に移動したときに何行スクロールするかの設定です。
;; 以下は 15 行の場合。
;; line-setting
(setq next-line-add-newlines nil)

(when (not next-line-add-newlines)
  (line-number-mode 15)
  (column-number-mode 15))

;; スクロール行単位を 1 行にします。
(setq-default scroll-step 1)
;; 画面をはみ出す場合に 1 行だけスクロールするようにします。
(setq-default scroll-conservatively 1)
;; カーソルを一番上か一番下まで持っていけます。
(setq-default scroll-margin 0)
;;
;; カーソルが右端、もしくは左端からはみ出したときに自動で横方向にスクロールします。
(setq-default truncate-lines t)
;; カーソルがどのくらいまで窓の端に近づいたらスクロールするかを指定します。
;(setq-default hscroll-margin 0)
;; スクロールの際にどの程度スクロールさせるかを指定します。
;(setq-default hscroll-step-percent 1)

;; 10 回毎に加速します。
(defvar scroll-speedup-count 10)
;; 10 回下カーソルを入力すると次回からは 1 + 1 で 2 行ずつの移動になります。
(defvar scroll-speedup-rate 1)
;; 800ms 経過したら通常のスクロールに戻します。
(defvar scroll-speedup-time 800)

;; 以下、内部変数がお送りします。
(defvar scroll-step-default 1)
(defvar scroll-step-count 1)
(defvar scroll-speedup-zero (current-time))
;; 内部変数がお送りしました。

;; via: http://www.bookshelf.jp/soft/meadow_31.html
(defun scroll-speedup-setspeed ()
  (let* ((now (current-time))
         (min (- (car now)
                 (car scroll-speedup-zero)))
         (sec (- (car (cdr now))
                 (car (cdr scroll-speedup-zero))))
         (msec
          (/ (- (car (cdr (cdr now)))
                (car
                 (cdr (cdr scroll-speedup-zero))))
             1000))
         (lag
          (+ (* 60000 min)
             (* 1000 sec) msec)))
    (if (> lag scroll-speedup-time)
        (progn
          (setq scroll-step-default 1)
          (setq scroll-step-count 1))
      (setq scroll-step-count
            (+ 1 scroll-step-count)))
    (setq scroll-speedup-zero (current-time))))

(defun scroll-speedup-next-line (arg)
  (if (= (% scroll-step-count
            scroll-speedup-count) 0)
      (setq scroll-step-default
            (+ scroll-speedup-rate
               scroll-step-default)))
  (if (string= arg 'next)
      (line-move scroll-step-default)
    (line-move (* -1 scroll-step-default))))

(defadvice next-line
  (around next-line-speedup activate)
  (if (and (string= last-command 'next-line)
           (interactive-p))
      (progn
        (scroll-speedup-setspeed)
        (condition-case err
            (scroll-speedup-next-line 'next)
          (error
           (if (and
                next-line-add-newlines
                (save-excursion
                  (end-of-line) (eobp)))
               (let ((abbrev-mode nil))
                 (end-of-line)
                 (insert "\n"))
             (line-move 1)))))
    (setq scroll-step-default 1)
    (setq scroll-step-count 1)
    ad-do-it))

(defadvice previous-line
  (around previous-line-speedup activate)
  (if (and
       (string= last-command 'previous-line)
       (interactive-p))
      (progn
        (scroll-speedup-setspeed)
        (scroll-speedup-next-line 'previous))
    (setq scroll-step-default 1)
    (setq scroll-step-count 1)
    ad-do-it))

;; カーソル位置を変更しないようにします。
(setq scroll-preserve-screen-position t)

;; スクロールバーを右側に置きます。
(set-scroll-bar-mode 'right)

;; 
;; ホイールでも 1 行ずつスクロールするようにします。
;; 
(global-set-key [wheel-up]
                '(lambda () "" (interactive) (scroll-down scroll-step)))
(global-set-key [wheel-down]
                '(lambda () "" (interactive) (scroll-up scroll-step)))
(global-set-key [double-wheel-up]
                '(lambda () "" (interactive) (scroll-down (* scroll-step 1.5))))
(global-set-key [double-wheel-down]
                '(lambda () "" (interactive) (scroll-up (* scroll-step 1.5))))
(global-set-key [triple-wheel-up]
                '(lambda () "" (interactive) (scroll-down (* scroll-step 2.5))))
(global-set-key [triple-wheel-down]
                '(lambda () "" (interactive) (scroll-up (* scroll-step 2.5))))

(provide 'init-scrolling)
;; init-scrolling.el ends here
