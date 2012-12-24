;; anthy-conf.el -- Anthy


;; Copyright (C) 2002
;; Author: Yusuke Tabata<yusuke@kmc.gr.jp>

;; This file is part of Anthy

;;; Commentary:
;;

(defvar anthy-alt-char-map
  '(("," "$B!$(B")
    ("." "$B!%(B")))

(defvar anthy-kana-mode-hiragana-map
  '(
    ("3" . "$B$"(B")    ("e" . "$B$$(B")    ("4" . "$B$&(B")    ("5" . "$B$((B")    ("6" . "$B$*(B")
    ("#" . "$B$!(B")    ("E" . "$B$#(B")    ("$" . "$B$%(B")    ("%" . "$B$'(B")    ("&" . "$B$)(B")
    ("t" . "$B$+(B")    ("g" . "$B$-(B")    ("h" . "$B$/(B")    (":" . "$B$1(B")    ("b" . "$B$3(B")
    ("t@" . "$B$,(B")    ("g@" . "$B$.(B")    ("h@" . "$B$0(B")    (":@" . "$B$2(B")    ("b@" . "$B$4(B")
    ("x" . "$B$5(B")    ("d" . "$B$7(B")    ("r" . "$B$9(B")    ("p" . "$B$;(B")    ("c" . "$B$=(B")
    ("x@" . "$B$6(B")    ("d@" . "$B$8(B")    ("r@" . "$B$:(B")    ("p@" . "$B$<(B")    ("c@" . "$B$>(B")
    ("q" . "$B$?(B")    ("a" . "$B$A(B")    ("z" . "$B$D(B")    ("w" . "$B$F(B")    ("s" . "$B$H(B")
    ("q@" . "$B$@(B")    ("a@" . "$B$B(B")    ("z@" . "$B$E(B")    ("w@" . "$B$G(B")    ("s@" . "$B$I(B")
    ("u" . "$B$J(B")    ("i" . "$B$K(B")    ("1" . "$B$L(B")    ("," . "$B$M(B")    ("k" . "$B$N(B")
    ("f" . "$B$O(B")    ("v" . "$B$R(B")    ("2" . "$B$U(B")    ("^" . "$B$X(B")    ("-" . "$B$[(B")
    ("f@" . "$B$P(B")    ("v@" . "$B$S(B")    ("2@" . "$B$V(B")    ("^@" . "$B$Y(B")    ("-@" . "$B$\(B")
    ("f[" . "$B$Q(B")    ("v[" . "$B$T(B")    ("2[" . "$B$W(B")    ("^[" . "$B$Z(B")    ("-[" . "$B$](B")
    ("j" . "$B$^(B")    ("n" . "$B$_(B")    ("]" . "$B$`(B")    ("/" . "$B$a(B")    ("m" . "$B$b(B")
    ("7" . "$B$d(B")    ("8" . "$B$f(B")    ("9" . "$B$h(B")
    ("'" . "$B$c(B")    ("(" . "$B$e(B")    (")" . "$B$g(B")
    ("o" . "$B$i(B")    ("l" . "$B$j(B")    ("." . "$B$k(B")    (";" . "$B$l(B")    ("\\" . "$B$m(B")
    ("0" . "$B$o(B")    ("~" . "$B$r(B")

;; $B:$$C$?$3$H$K(B $B%P%C%/%9%i%C%7%e$H1_$r6hJL$9$kJ}K!$,$o$+$i$J$$(B
    ("|" . "$B!<(B")    ("_" . "$B!<(B")
    ("Z" . "$B$C(B")    ("y" . "$B$s(B")
))

(defvar anthy-kana-mode-katakana-map
  '(
    ("3" . "$B%"(B")    ("e" . "$B%$(B")    ("4" . "$B%&(B")    ("5" . "$B%((B")    ("6" . "$B%*(B")
    ("#" . "$B%!(B")    ("E" . "$B%#(B")    ("$" . "$B%%(B")    ("%" . "$B%'(B")    ("&" . "$B%)(B")
    ("t" . "$B%+(B")    ("g" . "$B%-(B")    ("h" . "$B%/(B")    (":" . "$B%1(B")    ("b" . "$B%3(B")
    ("t@" . "$B%,(B")    ("g@" . "$B%.(B")    ("h@" . "$B%0(B")    (":@" . "$B%2(B")    ("b@" . "$B%4(B")
    ("x" . "$B%5(B")    ("d" . "$B%7(B")    ("r" . "$B%9(B")    ("p" . "$B%;(B")    ("c" . "$B%=(B")
    ("x@" . "$B%6(B")    ("d@" . "$B%8(B")    ("r@" . "$B%:(B")    ("p@" . "$B%<(B")    ("c@" . "$B%>(B")
    ("q" . "$B%?(B")    ("a" . "$B%A(B")    ("z" . "$B%D(B")    ("w" . "$B%F(B")    ("s" . "$B%H(B")
    ("q@" . "$B%@(B")    ("a@" . "$B%B(B")    ("z@" . "$B%E(B")    ("w@" . "$B%G(B")    ("s@" . "$B%I(B")
    ("u" . "$B%J(B")    ("i" . "$B%K(B")    ("1" . "$B%L(B")    ("," . "$B%M(B")    ("k" . "$B%N(B")
    ("f" . "$B%O(B")    ("v" . "$B%R(B")    ("2" . "$B%U(B")    ("^" . "$B%X(B")    ("-" . "$B%[(B")
    ("f@" . "$B%P(B")    ("v@" . "$B%S(B")    ("2@" . "$B%V(B")    ("^@" . "$B%Y(B")    ("-@" . "$B%\(B")
    ("f[" . "$B%Q(B")    ("v[" . "$B%T(B")    ("2[" . "$B%W(B")    ("^[" . "$B%Z(B")    ("-[" . "$B%](B")
    ("j" . "$B%^(B")    ("n" . "$B%_(B")    ("]" . "$B%`(B")    ("/" . "$B%a(B")    ("m" . "$B%b(B")
    ("7" . "$B%d(B")    ("8" . "$B%f(B")    ("9" . "$B%h(B")
    ("'" . "$B%c(B")    ("(" . "$B%e(B")    (")" . "$B%g(B")
    ("o" . "$B%i(B")    ("l" . "$B%j(B")    ("." . "$B%k(B")    (";" . "$B%l(B")    ("\\" . "$B%m(B")
    ("0" . "$B%o(B")    ("~" . "$B%r(B")

;; $B:$$C$?$3$H$K(B $B%P%C%/%9%i%C%7%e$H1_$r6hJL$9$kJ}K!$,$o$+$i$J$$(B
    ("|" . "$B!<(B")    ("_" . "$B!<(B")
    ("Z" . "$B%C(B")    ("y" . "$B%s(B")
))


;;
;; map$B$NJQ99(B
;;
(defun anthy-send-map-edit-command (mapno key str)
  (if (not (stringp key))
      (setq key (char-to-string key)))
  (if (not (stringp str))
      (setq str (char-to-string str)))
  (anthy-send-recv-command
   (concat " MAP_EDIT " (int-to-string mapno)
	   " " key " " str "\n")))
(defun anthy-change-hiragana-map (key str)
  (anthy-send-map-edit-command 2 key str))
(defun anthy-change-katakana-map (key str)
  (anthy-send-map-edit-command 3 key str))
(defun anthy-load-hiragana-map (map)
  (mapcar (lambda (x)
	    (let ((key (car x))
		  (str (cadr x)))
	      (anthy-change-hiragana-map key str))) map))
(defun anthy-clear-map ()
  (anthy-send-recv-command
   " MAP_CLEAR 0\n"))
;;
;; toggle$B$NJQ99(B
;;
(defun anthy-send-change-toggle-command (str)
  (anthy-send-recv-command
   (concat " MAP_EDIT " str "\n")))

;; should disable toggle
(defun anthy-kana-map-mode ()
  (setq anthy-rkmap-keybind nil)
  (anthy-send-change-toggle-command "!")
  (anthy-clear-map)
  (mapcar (lambda (x)
	    (anthy-change-hiragana-map (car x) (cdr x)))
	  anthy-kana-mode-hiragana-map)
  (mapcar (lambda (x)
	    (anthy-change-katakana-map (car x) (cdr x)))
	  anthy-kana-mode-katakana-map))
