;;; anthy.el -- Anthy

;; Copyright (C) 2001 - 2002
;; Author: Yusuke Tabata<yusuke@kmc.gr.jp>
;;         Tomoharu Ugawa
;; Keywords: japanese

;; This file is part of Anthy

;;; Commentary:
;;
;; $B$+$J4A;zJQ49%(%s%8%s(B Anthy$B$r(B emacs$B$+$i;H$&$?$a$N%W%m%0%i%`(B
;; Anthy$B%i%$%V%i%j$r;H$&$?$a$N%3%^%s%I(Banthy-agent$B$r5/F0$7$F!"(B
;; anthy-agent$B$H%Q%$%W$GDL?.$r$9$k$3$H$K$h$C$FJQ49$NF0:n$r9T$&(B
;;
;;
;; Funded by IPA$BL$F'%=%U%H%&%'%"AOB$;v6H(B 2001 10/10
;;
;; $B3+H/$O(Bemacs20.7$B>e$G9T$C$F$$$F(Bminor-mode
;; $B$b$7$/$O(Bleim$B$H$7$F$b;HMQ$G$-$k(B
;; (set-input-method 'japanese-anthy)
;;
;; emacs19(mule),20,21$B$GF0:n$9$k(B
;; xemacs$B$N>l9g$O8uJdA*Br%b!<%I$G%-!<$r2!$9$H$3$m$K%P%0$,$"$k(B
;;
;;
;;
;; 2001-11-16 EUC-JP -> ISO-2022-JP
;;
;; TODO
;;  multi-context$B2=(B
;;  minibufffer$B$N07$$(B
;;
;; $BMQ8l(B
;;  commit $BJ8;zNs$r3NDj$9$k$3$H(B
;;  preedit($B%W%j%(%G%#%C%H(B) $B3NDjA0$NJ8;zNs%"%s%@!<%i%$%s$d6/D4$NB0@-$b4^$`(B
;;  segment($BJ8@a(B) $BJ8K!E*$JJ8@a$G$O$J$/!$F1$8B0@-$NJ8;zNs$N$+$?$^$j(B
;;

;;; Code:
;(setq debug-on-error t)

(defvar anthy-default-enable-enum-candidate-p t
  "$B$3$l$r@_Dj$9$k$H<!8uJd$r?t2s2!$7$?:]$K8uJd$N0lMw$+$iA*Br$9$k%b!<%I$K$J$j$^$9!%(B")

(defconst anthy-working-buffer " *anthy*")
(defvar anthy-agent-process nil
  "anthy-agent$B$N%W%m%;%9(B")
;;
(defvar anthy-agent-command-list '("anthy-agent")
  "anthy-agent$B$N(BPATH$BL>(B")

;; face
(defvar anthy-hilight-face nil)
(defvar anthy-underline-face nil)
(copy-face 'highlight 'anthy-highlight-face)
(set-face-underline-p 'anthy-highlight-face t)
(copy-face 'underline 'anthy-underline-face)

;;
(defvar anthy-xemacs
  (if (featurep 'xemacs)
      t nil))
(if anthy-xemacs
    (require 'overlay))
;;
(defvar anthy-mode-map nil
  "Anthy$B$N(BASCII$B%b!<%I$N%-!<%^%C%W(B")
(or anthy-mode-map
    (let ((map (make-keymap))
	  (i 33))
      (define-key map (char-to-string 10) 'anthy-insert)
      (while (< i 127)
	(define-key map (char-to-string i) 'anthy-insert)
	(setq i (+ 1 i)))
      (setq anthy-mode-map map)))
;;
(defvar anthy-preedit-keymap nil
  "Anthy$B$N(Bpreedit$B$N%-!<%^%C%W(B")
(or anthy-preedit-keymap
    (let ((map (make-keymap))
	  (i 0))
      ;; $BDL>o$NJ8;z$KBP$7$F(B
      (while (< i 128)
	(define-key map (char-to-string i) 'anthy-insert)
	(setq i (+ 1 i)))
      ;; $B%P%C%/%9%Z!<%9(B
      (substitute-key-definition
       'delete-backward-char 'anthy-insert-backspace map global-map)
      ;; $BJ8@a$N?-=L(B
      (define-key map [(shift left)] 'anthy-insert)
      (define-key map [(shift right)] 'anthy-insert)
      ;; emacs$B$N<oN`$K1~$8$F:81&$NLp0u%-!<BP$9$kF0:n$r@_Dj$9$k(B
      (if anthy-xemacs
	  (progn
	    (substitute-key-definition
	     'backward-char-command 'anthy-insert-left map global-map)
	    (substitute-key-definition
	     'forward-char-command 'anthy-insert-right map global-map))
	(progn
	  (substitute-key-definition
	   'backward-char 'anthy-insert-left map global-map)
	  (substitute-key-definition
	   'forward-char 'anthy-insert-right map global-map)))
      (setq anthy-preedit-keymap map)))

;; anthy-agent$B$KAw$k:]$K%-!<$r%(%s%3!<%I$9$k$?$a$N%F!<%V%k(B
(defvar anthy-keyencode-alist
  '((1 . "(ctrl A)") ;; \C-a
    (2 . "(left)") ;; \C-b
    (4 . "(ctrl D)") ;; \C-d
    (5 . "(ctrl E)") ;; \C-e
    (6 . "(right)") ;; \C-f
    (7 . "(esc)") ;; \C-g
    (8 . "(ctrl H)") ;; \C-h
    (9 . "(shift left)") ;; \C-i
    (10 . "(ctrl J)")
    (11 . "(ctrl K)")
    (13 . "(enter)") ;; \C-m
    (14 . "(space)") ;; \C-n
    (15 . "(shift right)") ;; \C-o
    (16 . "(up)") ;; \C-p
    (32 . "(space)")
    (40 . "(opar)") ;; '('
    (41 . "(cpar)") ;; ')'
    (127 . "(ctrl H)")
    ;; emacs map
    (S-right . "(shift right)")
    (S-left . "(shift left)")
    (right . "(right)")
    (left . "(left)")
    (up . "(up)")
    ;; xemacs
    ((shift right) . "(shift right)")
    ((shift left) . "(shift left)")
    ((right) . "(right)")
    ((left) . "(left)")
    ((up) . "(up)")))

;; $B%b!<%I%i%$%s$NJ8;zNs(B
(defvar anthy-mode-line-string-alist
  '(("hiragana" . " Anthy: $B$"(B")
    ("katakana" . " Anthy: $B%"(B")
    ("alphabet" . " Anthy: A")
    ("walphabet" . " Anthy: $B#A(B")))

;; From skk-macs.el From viper-util.el.  Welcome!
(defmacro anthy-deflocalvar (var default-value &optional documentation)
  (` (progn
       (defvar (, var) (, default-value)
	 (, (format "%s\n\(buffer local\)" documentation)))
       (make-variable-buffer-local '(, var))
       )))

;; buffer local variables
; $B%b!<%I$N4IM}(B
(anthy-deflocalvar anthy-minor-mode nil)
(anthy-deflocalvar anthy-mode nil)
(anthy-deflocalvar anthy-leim-active-p nil)
(anthy-deflocalvar anthy-saved-mode nil)
; $B%W%j%(%G%#%C%H(B
(anthy-deflocalvar anthy-preedit "")
(anthy-deflocalvar anthy-preedit-start 0)
(anthy-deflocalvar anthy-preedit-overlays '())
(anthy-deflocalvar anthy-mode-line-string " Anthy:")
(anthy-deflocalvar anthy-enum-candidate-p nil)
(anthy-deflocalvar anthy-enum-rcandidate-p nil)
(anthy-deflocalvar anthy-candidate-minibuffer "")
(anthy-deflocalvar anthy-enum-candidate-list '())
(anthy-deflocalvar anthy-enable-enum-candidate-p 
  (cons anthy-default-enable-enum-candidate-p nil))
; $BF~NO>uBV(B
(anthy-deflocalvar anthy-current-rkmap "hiragana")

;;; setup minor-mode
;; minor-mode-alist
(if (not
     (assq 'anthy-minor-mode minor-mode-alist))
    (setq minor-mode-alist
       (cons
	(cons 'anthy-minor-mode '(anthy-mode-line-string))
	minor-mode-alist)))
;; minor-mode-map-alist
(if (not
     (assq 'anthy-minor-mode minor-mode-map-alist))
    (setq minor-mode-map-alist
       (cons
	(cons 'anthy-minor-mode anthy-mode-map)
	minor-mode-map-alist)))

;;
(defun anthy-process-sentinel (proc stat)
  "$B%W%m%;%9$N>uBV$,JQ2=$7$?$i;2>H$r>C$7$F!$<!$K:F5/F0$G$-$k$h$&$K$9$k(B"
  (message "%s" stat)
  (setq anthy-agent-process nil))

;;; status
(defun anthy-update-mode-line ()
  "$B%b!<%I%i%$%s$r99?7$9$k(B"
  (let ((a (assoc anthy-current-rkmap anthy-mode-line-string-alist)))
    (if a
      (setq anthy-mode-line-string (cdr a))))
  (force-mode-line-update))

;;; preedit control
(defun anthy-erase-preedit ()
  "$B%W%j%(%G%#%C%H$rA4It>C$9(B"
  (if (> (string-width anthy-preedit) 0)
      (let* ((str anthy-preedit)
	     (len (length str))
	     (start anthy-preedit-start))
	(delete-region start (+ start len))
	(goto-char start)))
  (setq anthy-preedit "")
  (mapcar 'delete-overlay anthy-preedit-overlays)
  (setq anthy-preedit-overlays nil))

(defun anthy-select-face-by-attr (attr)
  "$BJ8@a$NB0@-$K1~$8$?(Bface$B$rJV$9(B"
  (if (memq 'RV attr)
      'anthy-highlight-face
    'anthy-underline-face))

(defun anthy-enable-preedit-keymap ()
  "$B%-!<%^%C%W$r%W%j%(%G%#%C%H$NB8:_$9$k;~$N$b$N$K@ZBX$($k(B"
  (setcdr
   (assq 'anthy-minor-mode minor-mode-map-alist)
   anthy-preedit-keymap))

(defun anthy-disable-preedit-keymap ()
  "$B%-!<%^%C%W$r%W%j%(%G%#%C%H$NB8:_$7$J$$;~$N$b$N$K@ZBX$($k(B"
  (setcdr
   (assq 'anthy-minor-mode minor-mode-map-alist)
   anthy-mode-map)
  (anthy-update-mode-line))

(defun anthy-insert-preedit-segment (str attr)
  "$B%W%j%(%G%#%C%H$r0lJ8@aJ8DI2C$9$k(B"
  (let ((start (point))
	(end) (ol))
    (cond ((or (memq 'ENUM attr) (memq 'ENUMR attr))
	   (setq str (concat "<" str ">")))
	  ((memq 'RV attr) 
	   (setq str (concat "[" str "]"))))
    ; $B%W%j%(%G%#%C%H$NJ8;zNs$rDI2C$9$k(B
    (insert-and-inherit str)
    (setq end (point))
    ;; overlay$B$K$h$C$FB0@-$r@_Dj$9$k(B
    (setq ol (make-overlay start end))
    (overlay-put ol 'face (anthy-select-face-by-attr attr))
    (setq anthy-preedit-overlays
	  (cons ol anthy-preedit-overlays))
    str))

(defvar anthy-select-candidate-keybind
  '((0 . "a")
    (1 . "s")
    (2 . "d")
    (3 . "f")
    (4 . "g")
    (5 . "h")
    (6 . "j")
    (7 . "k")
    (8 . "l")
    (9 . ";")))

(defun anthy-get-candidate (idx)
  "agent$B$+$i8uJd$r0l$D<hF@$9$k(B"
  (anthy-send-recv-command 
   (concat " GET_CANDIDATE "
	   (number-to-string idx) "\n")))

(defun anthy-layout-candidate (idx nr)
  "$B8uJd$r(Bminibuffer$B$X%l%$%"%&%H$9$k(B"
  (let ((w (frame-width))
	(endp nil)
	(i 0)
	(firstp t)
	(errorp nil))
    (setq anthy-candidate-minibuffer "")
    (setq anthy-enum-candidate-list '())
    (cond
     ;; layout left to right
     (anthy-enum-candidate-p
      (while (and (not endp)
		  (< i (length anthy-select-candidate-keybind))
		  (< (+ idx i) nr)
		  (not errorp))
	(let ((repl (anthy-get-candidate (+ idx i))))
	  (if (listp repl)
	      (let ((str (concat anthy-candidate-minibuffer 
				 (if firstp "" " ") 
				 (cdr (assq
				       i anthy-select-candidate-keybind))
				 ":"
				 (car repl))))
		(if (or firstp (<= (string-width str) w))
		    (progn
		      (setq anthy-candidate-minibuffer str)
		      (setq anthy-enum-candidate-list
			    (cons (cons i (+ idx i)) 
				  anthy-enum-candidate-list)))
		  (setq endp t)))
	    (setq errorp t)))
	(setq firstp nil)
	(setq i (1+ i)))
      ;; set current candidate properly
      (anthy-get-candidate
       (cdr (car anthy-enum-candidate-list))))

     ;; layout right to left
     (anthy-enum-rcandidate-p
      (let ((cand-list '()))
	(while (and (< i (length anthy-select-candidate-keybind))
		    (<= i idx)
		    (> w 0)
		    (not errorp))
	  (let ((repl (anthy-get-candidate (- idx i))))
	    (if (listp repl)
		(progn
		  (setq w (- w 
			     (if (= i 0) 0 1) ; ' '
			     (string-width (car repl))
			     1               ; ':'
			     (string-width
			      (cdr (assq 
				    i anthy-select-candidate-keybind)))))
		  (if (or (= i 0) (>= w 0))
		      (setq cand-list (cons (cons i (car repl))
					    cand-list))))
	      (setq errorp t)))
	  (setq i (1+ i)))
	(if (or (>= i (length anthy-select-candidate-keybind))
		(> i idx) (and (< w 0) (> i 0)))
	    (setq i (1- i)))
	(let ((lst cand-list))
	  (while lst
	    (let ((c (car lst)))
	      (setq anthy-candidate-minibuffer
		    (concat anthy-candidate-minibuffer
			    (if (= (car c) i) "" " ")
			    (cdr (assq (- i (car c))
				       anthy-select-candidate-keybind))
			    ":"
			    (cdr c)))
	      (setq anthy-enum-candidate-list
		    (cons (cons (- i (car c)) (- idx (car c)))
			  anthy-enum-candidate-list)))
	    (setq lst (cdr lst)))))))
    ;; end layout
    (if (not errorp)
	(message "%s" anthy-candidate-minibuffer))))

(defun anthy-update-preedit (stat ps)
  "$B%W%j%(%G%#%C%H$r99?7$9$k(B"
  (let ((cursor-pos nil)
	(num-candidate 0)
	(idx-candidate 0))
    ;; erase old preedit
    (anthy-erase-preedit)
    (anthy-disable-preedit-keymap)
    ;; insert new preedit
    (setq anthy-preedit-start (point))
    (setq anthy-enum-candidate-p nil)
    (setq anthy-enum-rcandidate-p nil)
    (if (member stat '(2 3 4))
	(progn
	  (setq anthy-preedit
		(concat anthy-preedit "|"))
	  (anthy-insert-preedit-segment "|" '())))
    (while ps
      (let ((cur (car ps)))
	(setq ps (cdr ps))
	(cond
	 ((eq cur 'cursor)
	  (setq cursor-pos (point)))
	 ((string-equal (car (cdr cur)) "")
	  nil)
	 (t
	  (let ((nr (car (cdr (cdr (cdr cur)))))
		(idx (car (cdr (cdr cur))))
		(str (car (cdr cur)))
		(attr (car cur)))
	    (setq str (anthy-insert-preedit-segment str attr))
	    (cond ((and (car anthy-enable-enum-candidate-p) (memq 'ENUM attr))
		   (setq anthy-enum-candidate-p t)
		   (setq idx-candidate idx)
		   (setq num-candidate nr))
		  ((and (car anthy-enable-enum-candidate-p) (memq 'ENUMR attr))
		   (setq anthy-enum-rcandidate-p t)
		   (setq idx-candidate idx)
		   (setq num-candidate nr)))
	    (setq anthy-preedit
		  (concat anthy-preedit str))
	    (if (and (member stat '(3 4)) (not (eq ps '())))
		(progn
		  (setq anthy-preedit
			(concat anthy-preedit "|"))
		  (anthy-insert-preedit-segment "|" '()))))))))
    ;; enum candidate
    (if (or anthy-enum-candidate-p anthy-enum-rcandidate-p)
	(anthy-layout-candidate idx-candidate num-candidate))
    ;; update preedit keymap
    (if (member stat '(2 3 4))
	(anthy-enable-preedit-keymap))
    (if cursor-pos (goto-char cursor-pos))))

(if anthy-xemacs
    (defun anthy-encode-key (ch)
      (let* ((ccode (if (characterp ch)
			(char-to-int ch) nil))
	     (c))
	(setq c (assoc ccode anthy-keyencode-alist))
	(if c
	    (cdr c)
	  (setq c (assoc c anthy-keyencode-alist))
	  (if c
	      (cdr c)
	    (if (characterp ch)
		(char-to-string ch)
	      nil)))))
  (defun anthy-encode-key (ch)
    (let ((c (assoc ch anthy-keyencode-alist)))
      (if c
	  (cdr c)
	(if (and
	     (integerp ch)
	     (> ch 32))
	    (char-to-string ch)
	  nil)))))

(defun anthy-proc-agent-reply (repl)
  (let*
      ((stat (car repl))
       (body (cdr repl))
       (commit "")
       (preedit nil))
    (while body
      (let ((cur (car body)))
	(setq body (cdr body))
	(if (and (listp cur) (listp (car cur)))
	    (cond ((eq (car (car cur)) 'COMMIT)
		   (setq commit (concat commit (car (cdr cur)))))
		  ((eq (car (car cur)) 'CUTBUF)
		   (let ((len (length (car (cdr cur)))))
		     (copy-region-as-kill (point) (+ (point) len))))
		  ((memq 'UL (car cur))
		   (setq preedit (append preedit (list cur)))))
	  (setq preedit (append preedit (list cur))))))
    (if (> (string-width commit) 0)
	(progn
	  (anthy-erase-preedit)
	  (anthy-disable-preedit-keymap)
	  (insert-and-inherit commit)))
    (anthy-update-preedit stat preedit)
    (anthy-update-mode-line)))

(defun anthy-insert-select-candidate (ch)
  (let ((idx (cdr (assq (car (rassoc (char-to-string ch)
				     anthy-select-candidate-keybind))
			anthy-enum-candidate-list))))
    (if idx
	(progn
	  (let ((repl (anthy-send-recv-command
		       (concat " SELECT_CANDIDATE "
			       (number-to-string idx)
			       "\n"))))
	    (anthy-proc-agent-reply repl))
	  (setq anthy-enum-candidate-p nil)
	  (setq anthy-enum-rcandidate-p nil))
      (message "%s" anthy-candidate-minibuffer))))

(defvar anthy-rkmap-keybind
  '(
    ;; q
    (("hiragana" . 113) . "katakana")
    (("katakana" . 113) . "hiragana")
    ;; l
    (("hiragana" . 108) . "alphabet")
    (("katakana" . 108) . "alphabet")
    ;; L
    (("hiragana" . 76) . "walphabet")
    (("katakana" . 76) . "walphabet")
    ;; \C-j
    (("alphabet" . 10) . "hiragana")
    (("walphabet" . 10) . "hiragana")))

;; xemacs $B$O%-!<$N%O%s%I%iFb$G0lIt$N%-!<$KBP$7$F(B
;; $B$=$N860x$H$J$C$?%-!<$N>pJs$r<hF@$G$-$J$$(B(?)$B$N$G(B
;; $B$=$l$i$N%-!<$4$H$K%O%s%I%i$r=q$/(B
(defun anthy-insert-backspace (&optional arg)
  (interactive "*p") (anthy-handle-key 8 "(ctrl H)"))
(defun anthy-insert-left (&optional arg)
  (interactive "*p") (anthy-handle-key 2 "(left)"))
(defun anthy-insert-right (&optional arg)
  (interactive "*p") (anthy-handle-key 6 "(right)"))
;;
(defun anthy-insert (&optional arg)
  "Anthy$B$N%-!<%O%s%I%i(B"
  (interactive "*p")
  (let* ((ch last-command-char)
	 (chenc (anthy-encode-key ch)))
    (anthy-handle-key ch chenc)))

(defun anthy-handle-key (ch chenc)
  (cond
   ;; direct candidate selection
   ((and (or anthy-enum-candidate-p anthy-enum-rcandidate-p)
	 (integerp ch)
	 (assq (car (rassoc (char-to-string ch)
			    anthy-select-candidate-keybind))
	       anthy-enum-candidate-list))
    (anthy-insert-select-candidate ch))
   ;; map selection
   ((and (assoc (cons anthy-current-rkmap ch) anthy-rkmap-keybind)
	 (string-equal anthy-preedit ""))
    (let ((mapname (cdr (assoc (cons anthy-current-rkmap ch)
			       anthy-rkmap-keybind))))
      (let ((repl (anthy-send-recv-command 
		   (concat " MAP_SELECT " mapname "\n"))))
	(if (eq repl 'OK)
	    (progn
	      (setq anthy-current-rkmap
		    (cdr (assoc (cons anthy-current-rkmap ch)
				anthy-rkmap-keybind)))
	      (anthy-update-mode-line))))))
   ;; alphabet
   ((and (string-equal anthy-current-rkmap "alphabet")
	 (string-equal anthy-preedit ""))
    (self-insert-command 1))
   ;; normal input
   (t
    (let* ((repl
	    (if chenc (anthy-send-recv-command 
		       (concat chenc "\n"))
	      nil)))
      (if repl
	  (anthy-proc-agent-reply repl))))))

;;
(defun anthy-invoke-agent ()
  (let ((list anthy-agent-command-list)
	(proc nil))
    (while (and list (not proc))
      (setq proc 
	    (start-process "anthy-agent" anthy-working-buffer (car list)))
      (if (not (boundp 'proc))
	  (setq proc nil))
      (setq list (cdr list)))
    proc))
;;
;;
;;
(defun anthy-check-agent ()
  ;; check and do invoke
  (if (not anthy-agent-process)
      (let
	  ((proc (anthy-invoke-agent)))
	(if anthy-agent-process
	    (kill-process anthy-agent-process))
	(setq anthy-agent-process proc)
	(process-kill-without-query proc)
	(cond ((coding-system-p 'euc-japan)
	       (set-process-coding-system proc 'euc-japan 'euc-japan))
	      ((coding-system-p '*euc-japan*)
	       (set-process-coding-system proc '*euc-japan* '*euc-japan*)))
	(set-process-sentinel proc 'anthy-process-sentinel))))
;;
(defun anthy-send-recv-command (cmd)
  (if (not anthy-agent-process)
      (anthy-check-agent))
  (let ((old-buffer (current-buffer)))
    (unwind-protect
	(progn
	  (set-buffer anthy-working-buffer)
	  (erase-buffer)
	  (process-send-string anthy-agent-process cmd)
	  (while (= (buffer-size) 0)
	    (accept-process-output nil 0 50))
	  (read (buffer-string)))
      (set-buffer old-buffer))))
;;
(defun anthy-minibuffer-enter ()
  (setq anthy-saved-mode anthy-mode)
  (setq anthy-mode nil)
  (setq anthy-enable-enum-candidate-p 
	(cons nil anthy-enable-enum-candidate-p))
  (anthy-update-mode))
;;
(defun anthy-minibuffer-exit ()
  (setq anthy-mode anthy-saved-mode)
  (setq anthy-enable-enum-candidate-p 
	(cdr anthy-enable-enum-candidate-p))
  (anthy-update-mode))
;;
(defun anthy-mode-on ()
  (add-hook 'minibuffer-setup-hook 'anthy-minibuffer-enter)
  (add-hook 'minibuffer-exit-hook 'anthy-minibuffer-exit)
  (setq anthy-minor-mode t)
  (anthy-update-mode-line))
;;
(defun anthy-mode-off ()
  (setq anthy-minor-mode nil)
  (anthy-update-mode-line))
;;
(defun anthy-update-mode ()
  (if (or anthy-mode anthy-leim-active-p)
      (progn
	(anthy-check-agent)
	(anthy-mode-on))
    (anthy-mode-off)))

(defun anthy-mode (&optional arg)
  "Start Anthy conversion system."
  (interactive "P")
  (setq anthy-mode
        (if (null arg)
            (not anthy-mode)
          (> (prefix-numeric-value arg) 0)))
  (anthy-update-mode))
;;
(defun anthy-hiragana-map (&optional arg)
  "Hiragana mode"
  (interactive "P")
  (anthy-send-recv-command " MAP_SELECT hiragana\n"))
;;
(defun anthy-katakana-map (&optional arg)
  "Hiragana mode"
  (interactive "P")
  (anthy-send-recv-command " MAP_SELECT katakana\n"))
;;
(defun anthy-alpha-map (arg)
  "Alphabet mode"
  (interactive "P")
  (anthy-send-recv-command " MAP_SELECT alphabet\n"))
;;
(defun anthy-wide-alpha-map (arg)
  "Wide Alphabet mode"
  (interactive "P")
  (anthy-send-recv-command " MAP_SELECT walphabet\n"))
;;
;;
;; leim $B$N(B inactivate
;;
(defun anthy-leim-inactivate ()
  (setq anthy-leim-active-p nil)
  (anthy-update-mode))
;;
;; leim $B$N(B activate
;;
(defun anthy-leim-activate (&optional name)
  (setq inactivate-current-input-method-function 'anthy-leim-inactivate)
  (setq anthy-leim-active-p t)
  (anthy-update-mode)
  (when (eq (selected-window) (minibuffer-window))
    (add-hook 'minibuffer-exit-hook 'anthy-leim-exit-from-minibuffer)))

;;
;; emacs$B$N%P%0Hr$1$i$7$$$G$9(B
;;
(defun anthy-leim-exit-from-minibuffer ()
  (inactivate-input-method)
  (when (<= (minibuffer-depth) 1)
    (remove-hook 'minibuffer-exit-hook 'anthy-leim-exit-from-minibuffer)))
;;
;;
;;
(global-set-key [(meta escape)] 'anthy-mode)
(provide 'anthy)

(load "anthy-dic")
(load "anthy-conf")

;; these should go away for 18n
(if (boundp 'default-input-method)
    (setq-default default-input-method "japanese-anthy"))
(setq default-input-method "japanese-anthy")
;;;
;;; anthy.el ends here
